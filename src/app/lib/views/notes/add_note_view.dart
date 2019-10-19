import 'package:app/resources/resources.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNoteView extends ModelBoundWidget<AddNoteViewModel> {
  AddNoteView(AddNoteViewModel viewModel) : super(viewModel);

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends ModelBoundState<AddNoteView, AddNoteViewModel> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddNoteViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<AddNoteViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                FlatButton(
                  colorBrightness: Theme.of(context).brightness,
                  child: Text('SAVE'),
                  onPressed: () => viewModel.onCreateNote(
                    _titleController.text,
                    _noteController.text,
                  ),
                )
              ],
              bottom: PreferredSize(
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Take a note',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                preferredSize: Size(double.infinity, 40.0),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                child: ExtendedColumn(
                  spacing: 24.0,
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'My awesome note',
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: _noteController,
                      minLines: 4,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Pick up dry cleaning...',
                        labelText: 'Note',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
