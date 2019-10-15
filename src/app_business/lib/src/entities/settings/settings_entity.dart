import 'package:app_business/src/entities/account/account_type.dart';
import 'package:app_business/src/entities/settings/theme_config.dart';

class SettingsEntity {
  SettingsEntity({this.accountType, this.themeConfig});

  AccountType accountType;
  ThemeConfig themeConfig;
}
