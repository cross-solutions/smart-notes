import 'package:app/keys/widget_keys.dart';
import 'package:app/localization/i18n.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Use the snippet `mbw` to create a [ModelBoundWidget]

class MainView extends ModelBoundWidget<MainViewModel> {
  MainView(MainViewModel viewModel) : super(viewModel, key: MainViewKeys.view);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends ModelBoundState<MainView, MainViewModel> {
  @override
  Widget build(BuildContext context) {
    // We wrap the whole scaffold using a [ScopedModel] widget
    // that takes a listenable object, here we use a [ViewModel].
    // This is important so that we can detect changes in the
    // [ViewModel] using [ScopedModelDescendant].
    return ScopedModel<MainViewModel>(
      model: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(I18n.of(context).mainViewTitle),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ExtendedColumn(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // Here we are listening to changes using a [ScopedModelDescendant].
                // Every time the [ViewModel] changes, the callback we passed in
                // the [builder] parameter will be called. The [viewModel] parameter
                // in the callback is the updated [ViewModel]. You can use either this
                // parameter or the [ModelBoundState.viewModel] property.
                //
                // Only wrap the widget you need with [ScopedModelDescendant].
                ScopedModelDescendant<MainViewModel>(
                  builder: (_, __, viewModel) {
                    return Text(
                      I18n.of(context).mainViewCounter('${viewModel.counter}'),
                      key: MainViewKeys.counter,
                      style: Theme.of(context).textTheme.display1,
                    );
                    // Also valid
                    // return Text(
                    //   '${this.viewModel.counter}',
                    //   style: Theme.of(context).textTheme.display1,
                    // );
                  },
                ),
                Text(I18n.of(context).mainViewCurrentCounterValue),
                RaisedButton(
                  key: MainViewKeys.incrementButton,
                  child: Text(I18n.of(context).mainViewIncrementCounter),
                  onPressed: viewModel.incrementCounter,
                ),
                RaisedButton(
                  key: MainViewKeys.decrementButton,
                  child: Text(I18n.of(context).mainViewDecrementCounter),
                  onPressed: viewModel.decrementCounter,
                ),
                RaisedButton(
                  key: MainViewKeys.goToSecondView,
                  child: Text(I18n.of(context).mainViewGoToSecondView),
                  onPressed: viewModel.goToSecondView,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
