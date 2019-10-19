import 'package:app/models/models.dart';
import 'package:app/resources/resources.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesListView extends StatelessWidget {
  NotesListView({
    Key key,
    this.editingMode = ListEditingMode.none,
    this.onItemLongPress,
  }) : super(key: key);

  final ListEditingMode editingMode;
  final void Function() onItemLongPress;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NotesListViewModel>(
      model: ScopedModel.of<HomeViewModel>(context).notesListViewModel,
      child: ScopedModelDescendant<NotesListViewModel>(
        builder: (context, child, viewModel) {
          if (viewModel.notes.isEmpty)
            return _buildEmptyState(context);
          else
            return _buildListView(context, viewModel);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Opacity(
        opacity: 0.6,
        child: ExtendedColumn(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.0,
          children: <Widget>[
            Image.asset(
              AppImages.im_empty_note,
              width: 160.0,
              color: isDark ? Colors.white : Colors.grey[400],
              colorBlendMode: BlendMode.srcATop,
            ),
            Text('You have no notes'),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, NotesListViewModel viewModel) {
    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      crossAxisCount: 2,
      staggeredTileBuilder: (i) => StaggeredTile.count(1, i.isEven ? 1.2 : 1.5),
      itemCount: viewModel.notes.length,
      itemBuilder: (context, index) {
        return ScopedModel<NoteItemModel>(
          model: viewModel.notes[index],
          child: ScopedModelDescendant<NoteItemModel>(
            builder: (context, _, model) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              final isDeleting = editingMode == ListEditingMode.delete;
              final effectiveStyle = Theme.of(context).textTheme.title;
              final effectiveColor = effectiveStyle.color.withAlpha(128);
              var effectiveCardColor = Theme.of(context).cardTheme.color;
              var effectiveCardElevation = Theme.of(context).cardTheme.elevation;

              if (isDeleting && model.isSelected) {
                effectiveCardColor = isDark ? Colors.white38 : Colors.grey[200];
                effectiveCardElevation = 4.0;
              }

              return Card(
                key: Key(model.id),
                elevation: effectiveCardElevation,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.all(0.0),
                child: InkWell(
                  onLongPress: () {
                    viewModel.selectNote(model);
                    onItemLongPress();
                  },
                  onTap: () {
                    if (isDeleting && model.isSelected)
                      viewModel.unselectNote(model);
                    else if (isDeleting && !model.isSelected) viewModel.selectNote(model);
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
                            maxLines: index.isEven ? 6 : 9,
                            overflow: TextOverflow.ellipsis,
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
      },
    );
  }
}
