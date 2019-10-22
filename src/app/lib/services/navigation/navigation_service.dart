import 'package:app/keys/widget_keys.dart';
import 'package:app/service_locator.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';

abstract class NavigationService {
  Future push<T>(String viewnName, {T parameter});

  Future pushModal<T>(String viewName, {T parameter});

  Future pushReplacement(String viewName, {Object parameter});

  void pop<T>([T result]);
}

class NavigationServiceImpl implements NavigationService {
  NavigatorState get _navigator => AppViewKeys.navigator.currentState;

  @override
  Future push<T>(String viewName, {T parameter}) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameter),
      ),
    );
  }

  @override
  Future pushModal<T>(String viewName, {T parameter}) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameter),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Future pushReplacement(String viewName, {Object parameter}) async {
    _navigator.popUntil((route) => route.isFirst);
    await _navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameter),
      ),
    );
  }

  @override
  void pop<T>([T result]) => _navigator.pop(result);

  Widget _getViewAndInitParam<T>(String name, [T parameter]) {
    final view = ServiceLocator.resolveNamed<Widget>(name);

    if (view is ModelBoundWidget && view.viewModel is InitializableViewModel<T>) {
      InitializableViewModel<T> viewModel = view.viewModel;
      viewModel.initParameter(parameter);
    }

    return view;
  }
}
