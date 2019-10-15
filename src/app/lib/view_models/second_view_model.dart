import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';

class SecondViewModel extends InitializableViewModel<GenericViewParameter> {
  SecondViewModel(this.navigationService, this.dialogService) {
    loadData = _onLoadData();
  }

  final NavigationService navigationService;
  final DialogService dialogService;

  @override
  void initParameter(GenericViewParameter parameter) {
    assert(parameter != null);
    message = parameter.message;
  }

  Future<void> _loadData;
  Future<void> get loadData => _loadData;
  set loadData(Future<void> value) {
    if (_loadData == value) {
      _loadData = value;
      return;
    }
    _loadData = value;
    notifyListeners('loadData');
  }

  String _message;
  String get message => _message;
  set message(String value) {
    if (_message == value) {
      _message = value;
      return;
    }
    _message = value;
    notifyListeners('message');
  }

  Future<void> showConfirmationDialog() async {
    final confirmed = await dialogService.confirm('Do you want to confirm this?');

    if (confirmed == null)
      print('Cancelled');
    else if (confirmed)
      print('Confirmed');
    else
      print('Not confirmed');
  }

  Future<void> showAlertDialog() => dialogService.alert('This is an alert dialog');

  void goBack() => navigationService.pop('Result from Second View');

  Future<void> _onLoadData() => Future.delayed(Duration(seconds: 3));
}
