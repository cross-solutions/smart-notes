import 'package:app/keys/widget_keys.dart';
import 'package:app/resources/localization/i18n.dart';
import 'package:app/resources/resources.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:app_business/entities.dart';
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
      title: 'eNotes',
      debugShowCheckedModeBanner: false,
      themeMode: viewModel.settings.themeConfig == ThemeConfig.dark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
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
