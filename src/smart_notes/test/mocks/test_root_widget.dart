import 'package:smart_notes/keys/widget_keys.dart';
import 'package:smart_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TestRootWidget extends StatelessWidget {
  const TestRootWidget({this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Open Sans',
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      navigatorKey: AppViewKeys.navigator,
      home: child,
      builder: (_, widget) => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => DialogManagerWidget(child: widget),
        ),
      ),
    );
  }
}
