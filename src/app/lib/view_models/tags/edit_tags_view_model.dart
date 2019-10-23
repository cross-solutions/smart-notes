import 'package:app/models/notes/tag_item_model.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:uuid/uuid.dart';

class EditTagsViewModel extends InitializableViewModel<TagTransactionType> {
  EditTagsViewModel(
    this._tagsManager,
    this._accountManager,
    this._navigationService,
  ) {
    tags = [];
    _tagsManager.getTagsStream(_accountManager.currentAccount.id).listen(onTagsChanged);
  }

  final TagsManager _tagsManager;
  final AccountManager _accountManager;
  final NavigationService _navigationService;
  TagTransactionType _tagTransactionType;

  void onTagsChanged(List<TagEntity> newTags) {
    tags = newTags;
  }

  List<TagEntity> _tags;
  List<TagEntity> get tags => _tags;
  set tags(List<TagEntity> value) {
    if (_tags == value) {
      _tags = value;
      return;
    }
    _tags = value;
    notifyListeners('tags');
  }

  Future<void> onAddTag(String name) {
    return _tagsManager.addTag(TagEntity(
      id: Uuid().v1(),
      name: name,
      ownedBy: _accountManager.currentAccount.id,
    ));
  }

  void onTagTapped(TagEntity tag) {
    switch (_tagTransactionType) {
      case TagTransactionType.choose:
        _navigationService.pop(tag);
        break;
      case TagTransactionType.modify:
        break;
    }
  }

  @override
  void initParameter(TagTransactionType parameter) {
    _tagTransactionType = parameter ?? TagTransactionType.modify;
  }
}

enum TagTransactionType {
  choose,
  modify,
}
