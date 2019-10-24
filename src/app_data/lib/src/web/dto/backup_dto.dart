import 'package:app_data/database.dart';

class BackupDto {
  List<NoteDataObject> notes;
  List<TagDataObject> tags;

  BackupDto({
    this.notes,
    this.tags,
  });

  factory BackupDto.fromJson(Map<String, dynamic> json) => BackupDto(
        notes: List<NoteDataObject>.from(json['notes'].map((x) => NoteDataObject.fromJson(x))),
        tags: List<TagDataObject>.from(json['tags'].map((x) => TagDataObject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'notes': List<dynamic>.from(notes.map((x) => x.toJson())),
        'tags': List<dynamic>.from(tags.map((x) => x)),
      };
}
