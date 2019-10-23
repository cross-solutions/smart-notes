import 'dart:ffi';

import 'package:app/view_models/tags/edit_tags_view_model.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EditTagsView extends ModelBoundWidget<EditTagsViewModel> {
  EditTagsView(EditTagsViewModel viewModel) : super(viewModel);

  @override
  _EditTagsViewState createState() => _EditTagsViewState();
}

class _EditTagsViewState extends ModelBoundState<EditTagsView, EditTagsViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<EditTagsViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<EditTagsViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Select tag'),
            ),
            body: ListView(
              children: viewModel.tags
                  .map(
                    (t) => ListTile(
                      title: Text(t.name),
                      onTap: () => viewModel.onTagTapped(t),
                    ),
                  )
                  .toList()
                    ..add(ListTile(
                      leading: Icon(Icons.add_circle),
                      title: Text('Add tag'),
                      onTap: onShowAddTagDialog,
                    )),
            ),
          );
        },
      ),
    );
  }

  Future<void> onShowAddTagDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: 'New tag');

        return AlertDialog(
          title: Text('Add tag'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Tag name',
              border: UnderlineInputBorder(),
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
