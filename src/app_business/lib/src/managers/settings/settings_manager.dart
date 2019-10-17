

import 'package:app_business/src/entities/settings/settings_entity.dart';
import 'package:app_data/caching.dart';

abstract class SettingsManager {
  Future<SettingsEntity> get currentSettings;
}

class SettingsManagerImpl implements SettingsManager {
  SettingsManagerImpl(this._cacheService);

  final CacheService _cacheService;

  @override
  Future<SettingsEntity> get currentSettings => Future.value();
}
