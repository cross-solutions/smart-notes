import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';
import 'package:app_common/exceptions.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel(
    this._authManager,
    this._settingsManager,
    this._navigationService,
    this._dialogService,
  ) {
    isBackuping = false;
    isRestoring = false;

    _updateValues();
  }

  final AuthManager _authManager;
  final SettingsManager _settingsManager;
  final DialogService _dialogService;
  final NavigationService _navigationService;

  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    if (_isDarkMode == value) {
      _isDarkMode = value;
      return;
    }
    _isDarkMode = value;
    notifyListeners('isDarkMode');
  }

  bool _isSyncing;
  bool get isBackuping => _isSyncing;
  set isBackuping(bool value) {
    if (_isSyncing == value) {
      _isSyncing = value;
      return;
    }
    _isSyncing = value;
    notifyListeners('isSyncing');
  }

  bool _isRestoring;
  bool get isRestoring => _isRestoring;
  set isRestoring(bool value) {
    if (_isRestoring == value) {
      _isRestoring = value;
      return;
    }
    _isRestoring = value;
    notifyListeners('isRestoring');
  }

  Future<void> onBackupNotes() async {
    if (isBackuping || isRestoring) return;
    try {
      isBackuping = true;
      await _settingsManager.backupNotesToCloud();
    } on AuthException {
      print('Sign in required');
      _dialogService.alert('Please relogin and try to backup again.', title: 'Session expired');
    } finally {
      isBackuping = false;
    }
  }

  Future<void> onRestoreNotes() async {
    if (isBackuping || isRestoring) return;
    try {
      final shouldRestore = await _dialogService.confirm(
        'Restoring your notes will overwrite your existing notes locally.',
        title: 'Restore notes?',
        ok: 'Restore',
      );

      if (shouldRestore) {
        isRestoring = true;
        await _settingsManager.restoreNotesFromCloud();
      }
    } on AuthException {
      print('Sign in required');
      _dialogService.alert('Please relogin and try to restore again.', title: 'Session expired');
    } finally {
      isRestoring = false;
    }
  }

  Future<void> onSignOut() async {
    final shouldLogout = await _dialogService.confirm(
      'Are you sure you want to logout?',
      title: 'Logout account',
      ok: 'Logout',
    );

    if (shouldLogout == true) {
      await _authManager.signOut();
      await _settingsManager.resetSettings();
      await _navigationService.pushReplacement(ViewNames.loginView);
    }
  }

  Future<void> onUpdateTheme(bool isDarkMode) async {
    await _settingsManager.updateTheme(isDarkMode ? ThemeConfig.dark : ThemeConfig.light);
    await _updateValues();
  }

  Future<void> _updateValues() async {
    final newSettings = await _settingsManager.currentSettings;
    isDarkMode = newSettings.themeConfig == ThemeConfig.dark;
  }
}
