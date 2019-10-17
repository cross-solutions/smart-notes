// import 'dart:convert';

// import 'package:app_data/src/dto/drive/drive_data_dto.dart';
// import 'package:app_data/src/web/drive/drive_http_client.dart';
// import 'package:app_util/app_util.dart';
// import 'package:googleapis/drive/v3.dart';
// import 'dart:io' as io;

// import 'package:path_provider/path_provider.dart';

// abstract class DriveService {
//   Future<void> createDataFileIfNotExist();

//   Future<void> cleanUpLocalDataFile();
// }

// class DriveServiceImpl implements DriveService {
//   static const _dataFileName = 'enotes_data';
//   static const _dataFileMimeType = 'application/json';

//   @override
//   Future<void> createDataFileIfNotExist() async {
//     final client = DriveHttpClient();
//     final appDataPath = await getApplicationDocumentsDirectory();

//     try {
//       final driveApi = DriveApi(client);
//       final fileList = await driveApi.files.list(
//         spaces: 'appDataFolder',
//         q: 'name=\'$_dataFileName\' and mimeType=\'$_dataFileMimeType\' and trashed=false',
//       );

//       if (fileList.files.isEmpty) {
//         debugInfo('Data file does not exists in Google Drive, creating...');

//         final appInitialData = DriveDataDto(tags: [], notes: []);
//         final localDataFile = io.File('${appDataPath.path}/$_dataFileName.json');
//         final appInitialDataJson = jsonEncode(appInitialData.toJson());

//         await localDataFile.create();
//         await localDataFile.writeAsString(appInitialDataJson);

//         //TODO: For syncing functionality.
//         // final length = await localDataFile.length();
//         // final stream = localDataFile.openRead();
//         // final uploadMedia = Media(stream, length, contentType: '$_dataFileMimeType');

//         // final appDriveFile = File();
//         // appDriveFile.parents = ['appDataFolder'];
//         // appDriveFile.mimeType = '$_dataFileMimeType';
//         // appDriveFile.name = _dataFileName;
//         // await driveApi.files.create(appDriveFile, uploadMedia: uploadMedia);
//       } else {
//         final localDataFile = io.File('${appDataPath.path}/$_dataFileName.json');
//         final localDataFileExists = await localDataFile.exists();

//         if (!localDataFileExists) {
//           debugInfo('Downloading data file from Google Drive...');
//           Media file = await driveApi.files.get(fileList.files.first.id, downloadOptions: DownloadOptions.FullMedia);
//           final appDataJson = await utf8.decodeStream(file.stream);
//           await localDataFile.create();
//           await localDataFile.writeAsString(appDataJson);
//         } else {
//           debugInfo('Local data file exists.');
//         }
//       }
//     } finally {
//       client.close();
//     }
//   }

//   @override
//   Future<void> cleanUpLocalDataFile() async {
//     final appDataPath = await getApplicationDocumentsDirectory();
//     final localDataFile = io.File('${appDataPath.path}/$_dataFileName.json');
//     final localDataFileExists = await localDataFile.exists();

//     if (localDataFileExists) {
//       //TODO: Add sync to Google Drive.
//       debugInfo('Deleting local data file...');
//       await localDataFile.delete();
//     }
//   }
// }
