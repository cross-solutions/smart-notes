import 'package:app/view_models/view_models.dart';
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
    return Center(
      child: Text(viewModel.notes.length.toString()),
    );
  }
}
