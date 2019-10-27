import 'package:app/service_locator.dart';
import 'package:app/services/dialog/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:package_info/package_info.dart';

/// A custom widget for showing dialogs.
///
/// The [child] widget will be presented as the main content.
class DialogManagerWidget extends StatefulWidget {
  DialogManagerWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  _DialogManagerWidgetState createState() => _DialogManagerWidgetState();
}

class _DialogManagerWidgetState extends State<DialogManagerWidget> {
  DialogService _dialogService;
  bool _showingDialog = false;

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void initState() {
    _dialogService = ServiceLocator.resolve<DialogService>();
    _dialogService.registerCallbacks(
      onAlert: (message, title, ok) => _showAlertDialog(message, title, ok),
      onConfirm: (message, title, ok, cancel) => _showConfirmationDialog(message, title, ok, cancel),
      onAppInfo: () => _showAppInfoDialog(),
    );
    BackButtonInterceptor.add(myInterceptor);

    super.initState();
  }

  Future<void> _showAlertDialog(String message, String title, String ok) async {
    assert(message != null);
    assert(ok != null);

    _showingDialog = true;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );

    _showingDialog = false;
  }

  Future<bool> _showConfirmationDialog(String message, String title, String ok, String cancel) async {
    assert(message != null);
    assert(ok != null);
    assert(cancel != null);

    _showingDialog = true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(cancel),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text(ok),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    _showingDialog = false;

    return result;
  }

  void _showAppInfoDialog() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    _showingDialog = true;

    await showDialog(
      context: context,
      builder: (context) {
        return AboutDialog(
          applicationIcon: FlutterLogo(),
          applicationVersion: 'v$version, build $buildNumber',
          applicationName: appName,
          applicationLegalese: 'Copyright © 2019 Cross Solutions',
        );
      },
    );

    _showingDialog = false;
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    // This handles the back navigation in Android.
    // Pops the shown dialog.

    if (_showingDialog) {
      Navigator.of(context).pop();
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
