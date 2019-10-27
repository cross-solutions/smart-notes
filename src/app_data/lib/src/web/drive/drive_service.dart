import 'dart:convert';

import 'package:app_common/constants.dart';
import 'package:app_common/exceptions.dart';
import 'package:app_data/database.dart';
import 'package:app_data/src/local/cache/keystore_service.dart';
import 'package:app_data/src/local/database/repositories/notes/notes_repository.dart';
import 'package:app_data/src/web/drive/drive_http_client.dart';
import 'package:app_data/src/web/dto/backup_dto.dart';
import 'package:app_util/app_util.dart';
import 'package:googleapis/drive/v3.dart';

abstract class DriveService {
  Future<void> backupNotesToCloud(String ownedBy);

  Future<void> restoreNotesFromCloud();
}

class DriveServiceImpl implements DriveService {
  DriveServiceImpl(
    this._keyStoreService,
    this._notesRepository,
    this._tagsRepository,
  );

  static const _dataFileMimeType = 'application/json';
  static const _dataFileName = 'smart_notes_data';

  final KeyStoreService _keyStoreService;
  final NotesRepository _notesRepository;
  final TagsRepository _tagsRepository;

  @override
  Future<void> backupNotesToCloud(String ownedBy) async {
    final client = await createClient();

    try {
      final driveApi = DriveApi(client);
      final notes = await _notesRepository.selectAllOwnedNotes(ownedBy);
      final tags = await _tagsRepository.selectAllTagsNotes(ownedBy);
      final backupDto = BackupDto(notes: notes, tags: tags);
      final backupDataJson = backupDto.toJson();
      final backupDataJsonString = jsonEncode(backupDataJson);
      final backupDataBytes = utf8.encode(backupDataJsonString);
      final backupDataStream = Stream.value(backupDataBytes);
      final length = backupDataBytes.length;
      final uploadMedia = Media(backupDataStream, length, contentType: '$_dataFileMimeType');
      final appDriveFile = File();
      appDriveFile.mimeType = '$_dataFileMimeType';
      appDriveFile.name = _dataFileName;

      final driveResponse = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: 'name=\'$_dataFileName\' and mimeType=\'$_dataFileMimeType\' and trashed=false',
      );

      if (driveResponse.files.isEmpty) {
        debugInfo('Creating backup file...');
        appDriveFile.parents = ['appDataFolder'];
        await driveApi.files.create(appDriveFile, uploadMedia: uploadMedia);
      } else {
        debugInfo('Updating backup file...');
        final existingBackupData = driveResponse.files.first;
        await driveApi.files.update(appDriveFile, existingBackupData.id, uploadMedia: uploadMedia);
      }
    } on DetailedApiRequestError catch (dex) {
      if (dex.status == 401)
        throw AuthException('Session expired');
      else
        rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<void> restoreNotesFromCloud() async {
    final client = await createClient();

    try {
      final driveApi = DriveApi(client);
      final driveResponse = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: 'name=\'$_dataFileName\' and mimeType=\'$_dataFileMimeType\' and trashed=false',
      );
      if (driveResponse.files.isNotEmpty) {
        Media file = await driveApi.files.get(driveResponse.files.first.id, downloadOptions: DownloadOptions.FullMedia);
        final appDataJsonString = await utf8.decodeStream(file.stream);
        final appDatajson = jsonDecode(appDataJsonString);
        final backupDto = BackupDto.fromJson(appDatajson);

        debugInfo('Deleting local notes...');
        await _notesRepository.deleteAll();

        debugInfo('Deleting local tags...');
        await _tagsRepository.deleteAll();

        debugInfo('Restoring ${backupDto.notes.length} notes...');
        await _notesRepository.insertItems(backupDto.notes);

        debugInfo('Restoring ${backupDto.tags.length} tags...');
        await _tagsRepository.insertItems(backupDto.tags);
      }
    } on DetailedApiRequestError catch (dex) {
      if (dex.status == 401)
        throw AuthException('Session expired');
      else
        rethrow;
    } finally {
      client.close();
    }
  }

  Future<DriveHttpClient> createClient() async {
    final headers = await _keyStoreService.getJson(StorageKeys.authHeader);
    return DriveHttpClient(headers);
  }
}
