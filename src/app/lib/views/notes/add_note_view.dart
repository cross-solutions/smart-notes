import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class AddOrEditNoteView extends ModelBoundWidget<AddOrEditNoteViewModel> {
  AddOrEditNoteView(AddOrEditNoteViewModel viewModel) : super(viewModel);

  @override
  _AddOrEditNoteViewState createState() => _AddOrEditNoteViewState();
}

class _AddOrEditNoteViewState extends ModelBoundState<AddOrEditNoteView, AddOrEditNoteViewModel> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    viewModel.onTextRecognized((text) {
      _noteController.text = '${_noteController.text} $text';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddOrEditNoteViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<AddOrEditNoteViewModel>(
        builder: (context, child, viewModel) {
          final isEditing = viewModel.noteToEdit != null;

          if (isEditing) {
            _titleController.text = viewModel.noteToEdit.title;
            _noteController.text = viewModel.noteToEdit.content;
            return Hero(
              tag: viewModel.noteToEdit.id,
              child: _buildScaffold(context, isEditing),
            );
          } else
            return _buildScaffold(context, isEditing);
        },
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, bool isEditing) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: isEditing
            ? <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.deleteForever),
                  onPressed: viewModel.deleteNoteToEdit,
                  tooltip: 'Delete note',
                ),
                IconButton(
                  icon: Icon(MdiIcons.contentSaveEdit),
                  onPressed: () => viewModel.onAddOrSaveNote(
                    _titleController.text,
                    _noteController.text,
                  ),
                  tooltip: 'Save edit',
                )
              ]
            : <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.contentSave),
                  onPressed: () => viewModel.onAddOrSaveNote(
                    _titleController.text,
                    _noteController.text,
                  ),
                  tooltip: 'Save note',
                )
              ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('d'),
              IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(MdiIcons.textRecognition),
                onPressed: viewModel.onStartTextRecognitionFromCamera,
                tooltip: 'Recognize text',
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ExtendedColumn(
            spacing: 12.0,
            children: <Widget>[
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.title,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: viewModel.titlePlaceholder,
                ),
              ),
              TextField(
                controller: _noteController,
                minLines: 4,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Pick up dry cleaning...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
