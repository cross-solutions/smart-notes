import 'dart:async';

typedef AlertCallback = Future<void> Function(String message, String title, String ok);

typedef ConfirmCallback = Future<bool> Function(String message, String title, String ok, String cancel);

abstract class DialogService {
  void registerCallbacks({AlertCallback onAlert, ConfirmCallback onConfirm});

  /// Shows an alert dialog for user acknowledgement.
  Future<void> alert(String message, {String title, String ok = 'Ok'});

  /// Shows an alert dialog for user confirmation.
  ///
  /// Usage:
  /// ```
  /// bool confirmed = await confirm('Are you sure?');
  ///
  /// if (confirmed == null) {
  ///   // Dialog cancelled using back button (Android) or user tapped outside dialog.
  /// } else if (confirmed) {
  ///   // Confirm button clicked.
  /// } else if (!confirmed) {
  ///   // Cancel button clicked.
  /// }
  /// ```
  Future<bool> confirm(String message, {String title, String ok = 'Ok', String cancel = 'Cancel'});
}

class DialogServiceImpl implements DialogService {
  AlertCallback _onAlert;
  ConfirmCallback _onConfirm;

  @override
  void registerCallbacks({AlertCallback onAlert, ConfirmCallback onConfirm}) {
    _onAlert = onAlert;
    _onConfirm = onConfirm;
  }

  @override
  Future<void> alert(String message, {String title, String ok = 'Ok'}) => _onAlert(message, title, ok);

  @override
  Future<bool> confirm(String message, {String title, String ok = 'Ok', String cancel = 'Cancel'}) =>
      _onConfirm(message, title, ok, cancel);
}
