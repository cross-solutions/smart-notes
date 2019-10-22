import 'package:app_business/src/entities/settings/settings_entity.dart';
import 'package:app_business/src/entities/settings/theme_config.dart';
import 'package:app_common/constants.dart';
import 'package:app_data/caching.dart';
import 'package:app_data/web_services.dart';

abstract class SettingsManager {
  Future<SettingsEntity> get currentSettings;

  Future<void> resetSettings();

  Future<void> updateTheme(ThemeConfig theme);

  Future<void> backupNotesToCloud();

  Future<void> restoreNotesFromCloud();

  void onSettingsChanged(void Function() callback);
}

class SettingsManagerImpl implements SettingsManager {
  SettingsManagerImpl(this._cacheService, this._driveService);

  final CacheService _cacheService;
  final DriveService _driveService;

  void Function() _onSettingsChanged;

  @override
  Future<SettingsEntity> get currentSettings async {
    final themeValue = await _cacheService.getInt(StorageKeys.settingsTheme);
    final theme = ThemeConfig.values[themeValue ?? 0];

    return SettingsEntity(themeConfig: theme);
  }

  @override
  void onSettingsChanged(void Function() callback) => _onSettingsChanged = callback;

  @override
  Future<void> updateTheme(ThemeConfig theme) async {
    final themeValue = ThemeConfig.values.indexOf(theme);
    await _cacheService.setInt(StorageKeys.settingsTheme, themeValue);

    _onSettingsChanged();
  }

  @override
  Future<void> backupNotesToCloud() => _driveService.backupNotesToCloud();

  @override
  Future<void> restoreNotesFromCloud() => _driveService.restoreNotesFromCloud();

  @override
  Future<void> resetSettings() async {
    final themeValue = ThemeConfig.values.indexOf(ThemeConfig.light);
    await _cacheService.setInt(StorageKeys.settingsTheme, themeValue);

    _onSettingsChanged();
  }
}
