import 'dart:collection';

import 'package:app_business/src/entities/settings/settings_entity.dart';
import 'package:app_business/src/entities/settings/theme_config.dart';
import 'package:app_common/constants.dart';
import 'package:app_data/caching.dart';
import 'package:app_data/web_services.dart';

abstract class SettingsManager {
  Future<void> initialize();

  SettingsEntity get currentSettings;

  Future<void> resetSettings();

  Future<void> updateTheme(ThemeConfig theme);

  Future<void> backupNotesToCloud(String ownedBy);

  Future<void> restoreNotesFromCloud();

  void addListener(void Function() callback);

  void removeListener(void Function() callback);
}

class SettingsManagerImpl implements SettingsManager {
  SettingsManagerImpl(this._cacheService, this._driveService);

  final CacheService _cacheService;
  HashSet _callbacks = HashSet();
  SettingsEntity _currentSettings;
  final DriveService _driveService;

  @override
  SettingsEntity get currentSettings => _currentSettings;

  @override
  void addListener(void Function() callback) => _callbacks.add(callback);

  @override
  Future<void> backupNotesToCloud(String ownedBy) => _driveService.backupNotesToCloud(ownedBy);

  @override
  Future<void> initialize() async {
    final themeValue = await _cacheService.getInt(StorageKeys.settingsTheme);
    final theme = ThemeConfig.values[themeValue ?? 0];
    _currentSettings = SettingsEntity(themeConfig: theme);
    _raiseOnSettingsChanged(_currentSettings.themeConfig);
  }

  @override
  void removeListener(void Function() callback) => _callbacks.remove(callback);

  @override
  Future<void> resetSettings() async {
    final defaultTheme = ThemeConfig.light;
    final themeValue = ThemeConfig.values.indexOf(defaultTheme);

    await _cacheService.setInt(StorageKeys.settingsTheme, themeValue);

    _raiseOnSettingsChanged(defaultTheme);
  }

  @override
  Future<void> restoreNotesFromCloud() => _driveService.restoreNotesFromCloud();

  @override
  Future<void> updateTheme(ThemeConfig theme) async {
    final themeValue = ThemeConfig.values.indexOf(theme);
    await _cacheService.setInt(StorageKeys.settingsTheme, themeValue);

    _raiseOnSettingsChanged(theme);
  }

  void _raiseOnSettingsChanged(ThemeConfig newTheme) {
    final effectiveTheme = newTheme ?? _currentSettings.themeConfig;
    _currentSettings = SettingsEntity(themeConfig: effectiveTheme);
    _callbacks.forEach((c) => c());
  }
}
