import 'base_view_model.dart';

abstract class InitializableViewModel<T> extends BaseViewModel {
  void init(T parameter);
}
