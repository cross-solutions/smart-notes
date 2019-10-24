import 'package:app/models/models.dart';
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
    this._dialogService,
  ) {
    tags = [];
    editingMode = ListEditingMode.none;
    selectedTagsCount = 0;

    _tagsManager.getTagsStream(_accountManager.currentAccount.id).listen(onTagsChanged);
  }

  final AccountManager _accountManager;
  final TagsManager _tagsManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  TagTransactionType _tagTransactionType;

  List<TagItemModel> _tags;
  List<TagItemModel> get tags => _tags;
  set tags(List<TagItemModel> value) {
    if (_tags == value) {
      _tags = value;
      return;
    }
    _tags = value;
    notifyListeners('tags');
  }

  int _selectedTagsCount;
  int get selectedTagsCount => _selectedTagsCount;
  set selectedTagsCount(int value) {
    if (_selectedTagsCount == value) {
      _selectedTagsCount = value;
      return;
    }
    _selectedTagsCount = value;
    notifyListeners('selectedTagsCount');
  }

  ListEditingMode _editingMode;
  ListEditingMode get editingMode => _editingMode;
  set editingMode(ListEditingMode value) {
    if (_editingMode == value) {
      _editingMode = value;
      return;
    }
    _editingMode = value;
    notifyListeners('editingMode');
  }

  @override
  void initParameter(TagTransactionType parameter) => _tagTransactionType = parameter ?? TagTransactionType.modify;

  void onTagsChanged(List<TagEntity> newTags) {
    tags = newTags.map((t) {
      return TagItemModel(
        t.id,
        t.name,
        t.created,
      );
    }).toList();
  }

  void onToggleSelectAllTags() {
    final allNotesSelected = tags.every((n) => n.isSelected);

    if (allNotesSelected)
      tags.forEach((t) => t.isSelected = false);
    else
      tags.forEach((t) => t.isSelected = true);

    selectedTagsCount = tags.where((t) => t.isSelected).length;
  }

  void onToggleEditingMode() {
    switch (editingMode) {
      case ListEditingMode.none:
        editingMode = ListEditingMode.delete;
        break;

      case ListEditingMode.delete:
        editingMode = ListEditingMode.none;
        tags.forEach((t) => t.isSelected = false);
        break;
    }
  }

  void onToggleTagSelection(TagItemModel tag) {
    tag.isSelected = !tag.isSelected;
    selectedTagsCount = tags.where((n) => n.isSelected).length;
  }

  void Function() get onDeleteSelectedTags {
    if (selectedTagsCount == 0)
      return null;
    else {
      return () async {
        final tagsToBeDeleted = tags.where((t) => t.isSelected);
        for (final tag in tagsToBeDeleted) {
          await _tagsManager.deleteTag(TagEntity(id: tag.id));
        }

        onToggleEditingMode();
      };
    }
  }

  Future<void> onAddTag(String name) {
    final tagAlreadyExists = tags.any((t) => t.name == name);

    if (tagAlreadyExists) return _dialogService.alert('A tag with that name already exists.', title: 'Cannot add tag');

    return _tagsManager.addTag(TagEntity(
      id: Uuid().v1(),
      name: name,
      ownedBy: _accountManager.currentAccount.id,
      created: DateTime.now(),
    ));
  }

  void onTagTapped(TagItemModel tag) {
    switch (_tagTransactionType) {
      case TagTransactionType.choose:
        _navigationService.pop(tag);
        break;
      case TagTransactionType.modify:
        break;
    }
  }
}

enum TagTransactionType {
  choose,
  modify,
}
