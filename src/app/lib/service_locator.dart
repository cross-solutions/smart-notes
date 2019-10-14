import 'package:app/view_models/view_models.dart';
import 'package:app/services/services.dart';
import 'package:app/views/views.dart';
import 'package:app_constants/app_constants.dart';
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

      // Register View Models
      ..registerLazySingleton<AppViewModel>(() => AppViewModel(_i.get<AnalyticsService>(), _i.get<NavigationService>()))
      ..registerFactory<MainViewModel>(() => MainViewModel(_i.get<NavigationService>()))
      ..registerFactory<SecondViewModel>(() => SecondViewModel(_i.get<NavigationService>(), _i.get<DialogService>()))

      // Register services
      ..registerSingleton<NavigationService>(NavigationServiceImpl())
      ..registerSingleton<DialogService>(DialogServiceImpl())

      // Register Data
      ..registerSingleton<CacheService>(CacheServiceImpl())

      // Register Utilities
      ..registerSingleton<AnalyticsService>(AnalyticsServiceImpl());
  }

  static T resolve<T>() => _i.get<T>();

  static T resolveNamed<T>(String name) => _i.get(name) as T;
}
