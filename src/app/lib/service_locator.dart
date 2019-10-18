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
      ..registerFactory<Widget>(() => LoginView(i.get<LoginViewModel>()), instanceName: ViewNames.loginView)
      ..registerFactory<Widget>(() => HomeView(i.get<HomeViewModel>()), instanceName: ViewNames.homeView)

      // Register View Models
      ..registerLazySingleton<AppViewModel>(
          () => AppViewModel(i.get<AuthManager>(), i.get<AnalyticsService>(), i.get<NavigationService>()))
      ..registerFactory<LoginViewModel>(() => LoginViewModel(
            i.get<AuthManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<HomeViewModel>(() => HomeViewModel(
            i.get<NotesListViewModel>(),
            i.get<AccountManager>(),
            i.get<AuthManager>(),
            i.get<TagsManager>(),
            i.get<NavigationService>(),
            i.get<DialogService>(),
          ))
      ..registerFactory<NotesListViewModel>(() => NotesListViewModel(i.get<NotesManager>(), i.get<TagsManager>()))

      // Register Services
      ..registerSingleton<NavigationService>(NavigationServiceImpl())
      ..registerSingleton<DialogService>(DialogServiceImpl())

      // Register Managers
      ..registerLazySingleton<AuthManager>(() => AuthManagerImpl(
            i.get<AccountManager>(),
            i.get<AuthService>(),
            i.get<AccountMapper>(),
            i.get<KeyStoreService>(),
            i.get<AccountRepository>(),
          ))
      ..registerLazySingleton<AccountManager>(() => AccountManagerImpl())
      ..registerLazySingleton<TagsManager>(() => TagsManagerImpl(i.get<TagsRepository>(), i.get<TagMapper>()))
      ..registerLazySingleton<NotesManager>(() => NotesManagerImpl(i.get<NotesRepository>(), i.get<NotesMapper>()))

      // Register Mappers
      ..registerLazySingleton<GoogleAccountMapper>(() => GoogleAccountMapperImpl())
      ..registerLazySingleton<AccountMapper>(() => AccountMapperImpl(i.get<GoogleAccountMapper>()))
      ..registerLazySingleton<NotesMapper>(() => NotesMapperImpl())
      ..registerLazySingleton<TagMapper>(() => TagMapperImpl())

      // Register Data
      ..registerLazySingleton<ENotesDatabase>(() => ENotesDatabase())
      ..registerLazySingleton<TagsRepository>(() => TagsRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<AccountRepository>(() => AccountRepository(i.get<ENotesDatabase>()))
      ..registerLazySingleton<NotesRepository>(() => NotesRepository(i.get<ENotesDatabase>()))
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
