import 'package:app_business/src/entities/entities.dart';
import 'package:app_common/app_common.dart';
import 'package:app_data/app_data.dart';

abstract class SettingsManager {
  Future<SettingsEntity> get currentSettings;
}

class SettingsManagerImpl implements SettingsManager {
  SettingsManagerImpl(this._cacheService);

  final CacheService _cacheService;

  @override
  Future<SettingsEntity> get currentSettings => Future.value();
}
