import 'package:app/keys/widget_keys.dart';
import 'package:app/localization/i18n.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

class AppView extends ModelBoundWidget<AppViewModel> {
  AppView(AppViewModel viewModel) : super(viewModel, key: AppViewKeys.view);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends ModelBoundState<AppView, AppViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<AppViewModel>(
        builder: (context, child, viewModel) => _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    // Custom delegate that handles localization.
    final i18n = I18n.delegate;

    return MaterialApp(
      title: 'Sample App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: MaterialColor(
          4294872064,
          {
            50: Color(0xfffff4e5),
            100: Color(0xffffe8cc),
            200: Color(0xffffd199),
            300: Color(0xffffba66),
            400: Color(0xffffa333),
            500: Color(0xffff8d00),
            600: Color(0xffcc7000),
            700: Color(0xff995400),
            800: Color(0xff663800),
            900: Color(0xff331c00)
          },
        ),
        buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
        ),
        colorScheme: ColorScheme(
          primary: Color(0xfffe8c00),
          primaryVariant: Color(0xff995400),
          secondary: Color(0xffff8d00),
          secondaryVariant: Color(0xff995400),
          surface: Color(0xffffffff),
          background: Color(0xffffd199),
          error: Color(0xffd32f2f),
          onPrimary: Color(0xff000000),
          onSecondary: Color(0xff000000),
          onSurface: Color(0xff000000),
          onBackground: Color(0xff000000),
          onError: Color(0xffffffff),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          display1: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          title: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          button: TextStyle(
            letterSpacing: 0.4,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
      navigatorKey: AppViewKeys.navigator,
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      home: SplashWidget(),
      builder: (_, widget) => Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => DialogManagerWidget(child: widget),
        ),
      ),
    );
  }
}
