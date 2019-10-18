import 'package:app/models/listenable_model.dart';

class TagItemModel extends ListenableModel {
  TagItemModel(this.id, this.name) {
    isSelected = false;
  }

  final String id;
  final String name;

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
