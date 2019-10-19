import 'package:app/resources/app_images.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NotesListView extends StatelessWidget {
  NotesListView({Key key, this.viewModel}) : super(key: key);

  final NotesListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NotesListViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<NotesListViewModel>(
        builder: (_, __, ___) => _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    if (viewModel.notes.isEmpty) {
      return Center(
        child: ExtendedColumn(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('You have no notes'),
          ],
        ),
      );
    } else {
      return Center(
        child: ExtendedColumn(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.0,
          children: <Widget>[
            Image.asset(AppImages.im_empty_note),
            Text('You have ${viewModel.notes.length}'),
          ],
        ),
      );
    }
  }
}
