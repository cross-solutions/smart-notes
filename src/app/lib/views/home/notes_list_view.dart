import 'package:app/resources/resources.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/views/home/note_list_item.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesListView extends StatelessWidget {
  NotesListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeViewModel>(
      model: ScopedModel.of<HomeViewModel>(context),
      child: ScopedModelDescendant<HomeViewModel>(
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

  Widget _buildListView(BuildContext context, HomeViewModel viewModel) {
    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => StaggeredTile.count(1, index.isEven ? 1.2 : 1.5),
      itemCount: viewModel.notes.length,
      itemBuilder: (context, index) {
        final note = viewModel.notes[index];
        return AnimationConfiguration.staggeredGrid(
          key: Key(note.id),
          position: index,
          duration: const Duration(milliseconds: 250),
          columnCount: 2,
          child: FadeInAnimation(
            delay: Duration(milliseconds: 50),
            child: NoteListItem(
              model: note,
              editingMode: viewModel.editingMode,
              isIndexEven: index.isEven,
              onToggleEditingMode: viewModel.onToggleEditingMode,
              onToggleNoteSelection: viewModel.onToggleNoteSelection,
              onViewNote: viewModel.onViewNote,
            ),
          ),
        );
      },
    );
  }
}
