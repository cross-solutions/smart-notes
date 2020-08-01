import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';

typedef ModelChangeCallback = void Function(String name);

abstract class ListenableModel extends Model {
  final _callbacks = Set<ModelChangeCallback>();
  int _microtaskVersion = 0;
  int _version = 0;

  void addOnModelChanged(ModelChangeCallback callback) =>
      _callbacks.add(callback);

  void removeOnModelChanged(ModelChangeCallback callback) =>
      _callbacks.remove(callback);

  void removeAllOnModelChanged() => _callbacks.clear();

  @protected
  @mustCallSuper
  void notifyListeners([String name]) {
    super.notifyListeners();
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;
        _callbacks.toList().forEach((callback) => callback(name));
      });
    }
  }
}
