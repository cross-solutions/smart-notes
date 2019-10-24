import 'package:app/models/listenable_model.dart';
import 'package:app_business/entities.dart';

class NoteItemModel extends ListenableModel {
  NoteItemModel({
    this.id,
    this.tag,
    this.created,
    String title,
    String content,
    bool isSelected,
  }) {
    this.title = title;
    this.content = content;
    this.isSelected = false;
  }

  final String id;
  final DateTime created;
  final TagEntity tag;

  String _title;
  String get title => _title;
  set title(String value) {
    if (_title == value) {
      _title = value;
      return;
    }
    _title = value;
    notifyListeners('title');
  }

  String _content;
  String get content => _content;
  set content(String value) {
    if (_content == value) {
      _content = value;
      return;
    }
    _content = value;
    notifyListeners('content');
  }

  bool _isSelected;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    if (_isSelected == value) {
      _isSelected = value;
      return;
    }
    _isSelected = value;
    notifyListeners('isSelected');
  }
}
