import 'dart:async';

typedef AlertCallback = Future<void> Function(
    String message, String title, String ok);

typedef ConfirmCallback = Future<bool> Function(
    String message, String title, String ok, String cancel);

abstract class DialogService {
  void registerCallbacks(
      {AlertCallback onAlert,
      ConfirmCallback onConfirm,
      void Function() onAppInfo});

  Future<void> alert(String message, {String title, String ok = 'Ok'});

  Future<bool> confirm(String message,
      {String title, String ok = 'Ok', String cancel = 'Cancel'});

  void appInfo();
}

class DialogServiceImpl implements DialogService {
  AlertCallback _onAlert;
  ConfirmCallback _onConfirm;
  void Function() _onAppInfo;

  @override
  void registerCallbacks(
      {AlertCallback onAlert,
      ConfirmCallback onConfirm,
      void Function() onAppInfo}) {
    _onAlert = onAlert;
    _onConfirm = onConfirm;
    _onAppInfo = onAppInfo;
  }

  @override
  Future<void> alert(String message, {String title, String ok = 'Ok'}) =>
      _onAlert(message, title, ok);

  @override
  Future<bool> confirm(String message,
          {String title, String ok = 'Ok', String cancel = 'Cancel'}) =>
      _onConfirm(message, title, ok, cancel);

  @override
  void appInfo() => _onAppInfo();
}
