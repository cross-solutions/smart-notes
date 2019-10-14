import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_constants/app_constants.dart';

class MainViewModel extends BaseViewModel {
  // Assign [navigationService] directly from the constructor.
  MainViewModel(this.navigationService);

  final NavigationService navigationService;

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    if (_counter == value) {
      _counter = value;
      return;
    }
    _counter = value;
    notifyListeners('counter');
  }

  void incrementCounter() => counter++;

  void decrementCounter() => counter--;

  Future<void> goToSecondView() async {
    final result = await navigationService.push(
      ViewNames.secondView,
      parameter: GenericViewParameter('Hello from Second View!'),
    );

    print(result);
  }
}
