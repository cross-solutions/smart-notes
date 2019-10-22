import 'package:app/models/models.dart';
import 'package:app/models/notes/note_item_model.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NoteListItem extends StatelessWidget {
  NoteListItem({
    Key key,
    @required this.model,
    @required this.editingMode,
    @required this.isIndexEven,
    @required this.onToggleNoteSelection,
    @required this.onToggleEditingMode,
    @required this.onViewNote,
  }) : super(key: key);

  final NoteItemModel model;
  final ListEditingMode editingMode;
  final bool isIndexEven;
  final void Function(NoteItemModel note) onToggleNoteSelection;
  final void Function() onToggleEditingMode;
  final void Function(NoteItemModel note) onViewNote;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NoteItemModel>(
      model: model,
      child: ScopedModelDescendant<NoteItemModel>(
        builder: (context, _, model) {
          final currentTheme = Theme.of(context);
          final isDark = currentTheme.brightness == Brightness.dark;
          final isDeleting = editingMode == ListEditingMode.delete;
          final effectiveStyle = currentTheme.textTheme.title;
          final effectiveColor = effectiveStyle.color.withAlpha(128);
          var effectiveCardColor = currentTheme.cardTheme.color;
          var effectiveCardElevation = currentTheme.cardTheme.elevation;

          if (isDeleting && model.isSelected) {
            effectiveCardColor = isDark ? Colors.white38 : Colors.grey[200];
            effectiveCardElevation = 4.0;
          }

          return Hero(
            tag: model.id,
            child: Card(
              elevation: effectiveCardElevation,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.all(0.0),
              child: InkWell(
                onLongPress: () {
                  if (!isDeleting) {
                    onToggleNoteSelection(model);
                    onToggleEditingMode();
                  }
                },
                onTap: () {
                  if (isDeleting)
                    onToggleNoteSelection(model);
                  else
                    onViewNote(model);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeOutSine,
                  decoration: BoxDecoration(color: effectiveCardColor),
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
                  child: ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        model.title,
                        style: effectiveStyle.apply(color: effectiveColor),
                      ),
                      Expanded(
                        child: Text(
                          model.content,
                          maxLines: isIndexEven ? 6 : 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
