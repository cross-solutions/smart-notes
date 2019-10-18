import 'package:app/view_models/view_models.dart';
import 'package:app/services/services.dart';
import 'package:app/views/views.dart';
import 'package:app_common/constants.dart';
import 'package:app_util/app_util.dart';
import 'package:app_data/caching.dart';
import 'package:app_data/database.dart';
import 'package:app_data/web_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_business/managers.dart';
import 'package:app_business/mappers.dart';

class ServiceLocator {
  static bool configured = false;

  @protected
  static final i = GetIt.instance;

  static void configure() {
    assert(!configured);
    i
      // Register Views
      ..registerLazySingleton<AppView>(() => AppView(i.get<AppViewModel>()))
      ..registerFactory<Widget>(() => MainView(i.get<MainViewModel>()), instanceName: ViewNames.mainView)
      ..registerFactory<Widget>(() => SecondView(i.get<SecondViewModel>()), instanceName: ViewNames.secondView)
      ..registerFactory<Widget>(() => LoginView(i.get<LoginViewModel>()), instanceName: ViewNames.loginView)
      ..registerFactory<Widget>(() => HomeView(i.get<HomeViewModel>()), instanceName: ViewNames.homeView)

      // Register View Models
      ..registerLazySingleton<AppViewModel>(
          () => AppViewModel(i.get<AuthManager>(), i.get<AnalyticsService>(), i.get<NavigationService>()))
      ..registerFactory<MainViewModel>(() => MainViewModel(i.get<NavigationService>()))
      ..registerFactory<SecondViewModel>(() => SecondViewModel(i.get<NavigationService>(), i.get<DialogService>()))
      ..registerFactory<LoginViewModel>(
          () => LoginViewModel(i.get<AuthManager>(), i.get<NavigationService>(), i.get<DialogService>()))
      ..registerFactory<HomeViewModel>(() => HomeViewModel(
          i.get<AccountManager>(), i.get<AuthManager>(), i.get<NavigationService>(), i.get<DialogService>()))

      // Register Services
      ..registerSingleton<NavigationService>(NavigationServiceImpl())
      ..registerSingleton<DialogService>(DialogServiceImpl())

      // Register Managers
      ..registerLazySingleton<AuthManager>(() => AuthManagerImpl(i.get<AccountManager>(), i.get<AuthService>(),
          i.get<AccountMapper>(), i.get<KeyStoreService>(), i.get<AccountRepository>()))
      ..registerLazySingleton<AccountManager>(() => AccountManagerImpl())

      // Register Mappers
      ..registerLazySingleton<GoogleAccountMapper>(() => GoogleAccountMapperImpl())
      ..registerLazySingleton<AccountMapper>(() => AccountMapperImpl(i.get<GoogleAccountMapper>()))

      // Register Data
      ..registerLazySingleton<ENotesDatabase>(() => ENotesDatabase())
      ..registerLazySingleton<TagsRepository>(() => TagsRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<AccountRepository>(() => AccountRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<CacheService>(() => CacheServiceImpl())
      ..registerLazySingleton<KeyStoreService>(() => KeyStoreServiceImpl())

      // Register Web
      ..registerLazySingleton<AuthService>(() => AuthServiceImpl())

      // Register Utilities
      ..registerLazySingleton<AnalyticsService>(() => AnalyticsServiceImpl());

    configured = true;
  }

  static T resolve<T>() => i.get<T>();

  static T resolveNamed<T>(String name) => i.get(name) as T;
}
