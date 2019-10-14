import 'package:app/keys/widget_keys.dart';
import 'package:app/localization/i18n.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SecondView extends ModelBoundWidget<SecondViewModel> {
  SecondView(SecondViewModel viewModel) : super(viewModel, key: SecondViewKeys.view);

  @override
  _SecondViewState createState() => _SecondViewState();
}

class _SecondViewState extends ModelBoundState<SecondView, SecondViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).secondViewTitle),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // A [FutureBuilder] allows us to show different widgets
    // depending on the latest computation of a [Future].
    return FutureBuilder<void>(
      future: viewModel.loadData,
      builder: (context, snapshot) {
        // Build the main content if the [Future] completes.
        if (snapshot.connectionState == ConnectionState.done)
          return _buildMainContent();

        // Otherwise, show a loading state.
        else
          return _buildLoadingContent();
      },
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: ExtendedColumn(
        spacing: 16.0,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(viewModel.message),
          RaisedButton(
            child: Text(I18n.of(context).secondViewGoBack),
            onPressed: viewModel.goBack,
          ),
          RaisedButton(
            child: Text(I18n.of(context).secondViewShowAlertDialog),
            onPressed: viewModel.showAlertDialog,
          ),
          RaisedButton(
            child: Text(I18n.of(context).secondViewShowConfirmationDialog),
            onPressed: viewModel.showConfirmationDialog,
          )
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: ExtendedColumn(
        mainAxisSize: MainAxisSize.min,
        spacing: 16.0,
        children: <Widget>[
          SizedBox(
            width: 56.0,
            height: 56.0,
            child: CircularProgressIndicator(strokeWidth: 6),
          ),
          Text(I18n.of(context).secondViewSomethingIsLoading)
        ],
      ),
    );
  }
}
