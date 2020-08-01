import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class NoteView extends ModelBoundWidget<NoteViewModel> {
  NoteView(NoteViewModel viewModel) : super(viewModel);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends ModelBoundState<NoteView, NoteViewModel> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    _titleController
        .addListener(() => viewModel.note.title = _titleController.text);
    _noteController
        .addListener(() => viewModel.note.content = _noteController.text);
    viewModel.onTextRecognized(
        (text) => _noteController.text = '${_noteController.text} $text');
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NoteViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<NoteViewModel>(
        builder: (context, child, viewModel) {
          if (viewModel.isEditing) {
            _titleController.text = viewModel.note.title;
            _noteController.text = viewModel.note.content;
            return Hero(
              tag: viewModel.note.id,
              child: _buildScaffold(context),
            );
          } else
            return _buildScaffold(context);
        },
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final effectiveColor = isDark ? Colors.white60 : Colors.grey[500];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions:
            viewModel.isEditing ? _buildEditActions() : _buildSaveActions(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ExtendedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.0,
            children: <Widget>[
              OutlineButton(
                textColor: effectiveColor,
                color: effectiveColor,
                borderSide: BorderSide(color: effectiveColor),
                child: Text(viewModel.assignedTag?.name ?? 'Untagged'),
                onPressed: viewModel.onSelectTag,
              ),
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'My awesome note',
                ),
              ),
              TextField(
                controller: _noteController,
                minLines: 4,
                autofocus: !viewModel.isEditing,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'What\'s on your mind?',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  viewModel.note.formattedLastModified ??
                      viewModel.note.formattedCreated ??
                      '',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
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
    );
  }

  List<Widget> _buildSaveActions() {
    return <Widget>[
      IconButton(
        icon: Icon(MdiIcons.contentSave),
        onPressed: viewModel.onSaveNote,
        tooltip: 'Save note',
      )
    ];
  }

  List<Widget> _buildEditActions() {
    return <Widget>[
      IconButton(
        icon: Icon(MdiIcons.deleteForever),
        onPressed: viewModel.deleteNoteToEdit,
        tooltip: 'Delete note',
      ),
      IconButton(
        icon: Icon(MdiIcons.contentSaveEdit),
        onPressed: viewModel.onSaveEditedNote,
        tooltip: 'Save edit',
      )
    ];
  }
}
