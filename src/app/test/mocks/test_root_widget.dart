import 'package:app/keys/widget_keys.dart';
import 'package:app/localization/i18n.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TestRootWidget extends StatelessWidget {
  const TestRootWidget({this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Custom delegate that handles localization.
    final i18n = I18n.delegate;

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
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      home: child,
      builder: (_, widget) => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => DialogManagerWidget(child: widget),
        ),
      ),
    );
  }
}
