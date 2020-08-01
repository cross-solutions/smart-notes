import 'package:smart_notes/models/listenable_model.dart';

class TagItemModel extends ListenableModel {
  TagItemModel(
    this.id,
    this.name,
    this.created,
    this.lastModified,
  ) {
    isSelected = false;
  }

  final String id;
  final String name;
  final DateTime created;
  final DateTime lastModified;

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
