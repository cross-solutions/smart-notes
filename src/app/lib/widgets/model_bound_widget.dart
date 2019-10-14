import 'package:app/view_models/view_models.dart';
import 'package:flutter/material.dart';

abstract class ModelBoundWidget<TViewModel extends BaseViewModel> extends StatefulWidget {
  ModelBoundWidget(this.viewModel, {Key key}) : super(key: key);

  final TViewModel viewModel;
}

abstract class ModelBoundState<TWidget extends ModelBoundWidget, TViewModel extends BaseViewModel>
    extends State<TWidget> {
  TViewModel _viewModel;

  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  TViewModel get viewModel => _viewModel ??= widget.viewModel;
}
