import 'package:app/models/models.dart';
import 'package:app/view_models/tags/tags_view_model.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scoped_model/scoped_model.dart';

class TagsView extends ModelBoundWidget<TagsViewModel> {
  TagsView(TagsViewModel viewModel) : super(viewModel);

  @override
  _TagsViewState createState() => _TagsViewState();
}

class _TagsViewState extends ModelBoundState<TagsView, TagsViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TagsViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<TagsViewModel>(
        builder: (context, child, viewModel) {
          final isDeleting = viewModel.editingMode == ListEditingMode.delete;
          List<Widget> listItems = List<Widget>();
          listItems.addAll(viewModel.tags.map((t) {
            return ScopedModel<TagItemModel>(
              model: t,
              child: ScopedModelDescendant<TagItemModel>(
                builder: (context, _, model) {
                  return AnimationConfiguration.staggeredList(
                    key: Key(t.id),
                    position: viewModel.tags.indexOf(t),
                    duration: const Duration(milliseconds: 250),
                    child: FadeInAnimation(
                      delay: Duration(milliseconds: 50),
                      child: ListTile(
                        leading: isDeleting
                            ? Checkbox(
                                onChanged: (_) => viewModel.onToggleTagSelection(model),
                                value: model.isSelected,
                              )
                            : null,
                        title: Text(t.name),
                        contentPadding: isDeleting
                            ? const EdgeInsets.symmetric(horizontal: 16.0)
                            : const EdgeInsets.symmetric(horizontal: 32.0),
                        onTap: () {
                          if (isDeleting)
                            viewModel.onToggleTagSelection(model);
                          else
                            viewModel.onTagTapped(t);
                        },
                        onLongPress: () {
                          if (!isDeleting) {
                            viewModel.onToggleEditingMode();
                            viewModel.onToggleTagSelection(t);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }));
          listItems.add(AnimatedOpacity(
            opacity: isDeleting ? 0.33 : 1.0,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeOutSine,
            child: IgnorePointer(
              ignoring: isDeleting,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: _onShowAddTagDialog,
                ),
                title: Text('Add tag'),
                onTap: _onShowAddTagDialog,
              ),
            ),
          ));

          return WillPopScope(
            onWillPop: viewModel.onBackPressed,
            child: Scaffold(
              appBar: _buildAppBar(isDeleting),
              body: ListView(children: listItems),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(bool isDeleting) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 96),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 250),
            firstCurve: Curves.easeOutSine,
            secondCurve: Curves.easeOutSine,
            crossFadeState: isDeleting ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: ExtendedRow(
              spacing: 16.0,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => viewModel.onBackPressed(true),
                ),
                Text(
                  'Tags',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            secondChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ExtendedRow(
                  spacing: 12.0,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: viewModel.onToggleEditingMode,
                    ),
                    Text(
                      'Select ${viewModel.selectedTagsCount} tag/s',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
                ExtendedRow(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.0,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.select_all),
                      onPressed: viewModel.onToggleSelectAllTags,
                      tooltip: 'Select All',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: viewModel.onDeleteSelectedTags,
                      tooltip: 'Delete',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onShowAddTagDialog() {
    final controller = TextEditingController(text: 'New tag');

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add tag'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Tag name',
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                viewModel.onAddTag(controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}
