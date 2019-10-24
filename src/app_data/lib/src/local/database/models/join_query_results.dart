import 'package:app_data/src/local/database/models/models.dart';

class NoteWithTag {
  NoteWithTag(this.note, this.tag);

  final NoteDataObject note;
  final TagDataObject tag;
}
