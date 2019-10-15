import 'package:app/view_models/view_models.dart';
import 'package:app/services/services.dart';
import 'package:app/views/views.dart';
import 'package:app_business/app_business.dart';
import 'package:app_common/app_common.dart';
import 'package:app_util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_data/app_data.dart';

class ServiceLocator {
  static final _i = GetIt.instance;

  /// Register our dependencies that we will use.
  /// Because `dart:mirrors` (reflection) is disabled in Flutter,
  /// it is best to use the *Service Locator* pattern.
  static void configure() {
    // Use cascade operation to chain calls from an object.
    _i
      // Register Views
      ..registerLazySingleton<AppView>(() => AppView(_i.get<AppViewModel>()))
      ..registerFactory<Widget>(() => MainView(_i.get<MainViewModel>()), instanceName: ViewNames.mainView)
      ..registerFactory<Widget>(() => SecondView(_i.get<SecondViewModel>()), instanceName: ViewNames.secondView)
      ..registerFactory<Widget>(() => LoginView(_i.get<LoginViewModel>()), instanceName: ViewNames.loginView)
      ..registerFactory<Widget>(() => HomeView(_i.get<HomeViewModel>()), instanceName: ViewNames.homeView)

      // Register View Models
      ..registerLazySingleton<AppViewModel>(() => AppViewModel(
            _i.get<AuthManager>(),
            _i.get<AnalyticsService>(),
            _i.get<NavigationService>(),
          ))
      ..registerFactory<MainViewModel>(() => MainViewModel(_i.get<NavigationService>()))
      ..registerFactory<SecondViewModel>(() => SecondViewModel(_i.get<NavigationService>(), _i.get<DialogService>()))
      ..registerFactory<LoginViewModel>(() => LoginViewModel(
            _i.get<AuthManager>(),
            _i.get<NavigationService>(),
            _i.get<DialogService>(),
          ))
      ..registerFactory<HomeViewModel>(() => HomeViewModel(
            _i.get<AccountManager>(),
            _i.get<AuthManager>(),
            _i.get<NavigationService>(),
            _i.get<DialogService>(),
          ))

      // Register Services
      ..registerSingleton<NavigationService>(NavigationServiceImpl())
      ..registerSingleton<DialogService>(DialogServiceImpl())

      // Register Managers
      ..registerLazySingleton<AuthManager>(
          () => AuthManagerImpl(_i.get<AccountManager>(), _i.get<AuthService>(), _i.get<AccountMapper>()))
      ..registerLazySingleton<AccountManager>(() => AccountManagerImpl())

      // Register Mappers
      ..registerLazySingleton<AccountMapper>(() => AccountMapperImpl())

      // Register Data
      ..registerSingleton<CacheService>(CacheServiceImpl())

      // Register Web
      ..registerLazySingleton<AuthService>(() => AuthServiceImpl())

      // Register Utilities
      ..registerSingleton<AnalyticsService>(AnalyticsServiceImpl());
  }

  static T resolve<T>() => _i.get<T>();

  static T resolveNamed<T>(String name) => _i.get(name) as T;
}
