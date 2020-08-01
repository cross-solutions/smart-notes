import 'package:smart_notes/services/services.dart';
import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes_business/entities.dart';
import 'package:smart_notes_business/managers.dart';
import 'package:smart_notes_common/constants.dart';
import 'package:smart_notes_common/exceptions.dart';
import 'package:smart_notes_util/app_util.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel(
    this._authManager,
    this._accountManager,
    this._settingsManager,
    this._navigationService,
    this._dialogService,
  ) {
    isDarkMode =
        _settingsManager.currentSettings.themeConfig == ThemeConfig.dark;
    _settingsManager.addListener(_onSettingsChanged);
    isBackuping = false;
    isRestoring = false;
  }

  final AccountManager _accountManager;
  final AuthManager _authManager;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final SettingsManager _settingsManager;

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

  @override
  void dispose() => _settingsManager.removeListener(_onSettingsChanged);

  Future<void> onBackupNotes() async {
    if (isBackuping || isRestoring) return;
    try {
      final shouldBackup = await _dialogService.confirm(
        'Creating a backup of your current local notes will overwrite any existing backup.',
        title: 'Backup notes?',
        ok: 'Backup',
      );

      if (shouldBackup == true) {
        isBackuping = true;
        await _settingsManager
            .backupNotesToCloud(_accountManager.currentAccount.id);
        _dialogService.alert('Your notes has been uploaded and saved.',
            title: 'Backup notes');
      }
    } on AuthException {
      debugInfo('Sign in required');
      _dialogService.alert('Please relogin and try to backup again.',
          title: 'Session expired');
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

      if (shouldRestore == true) {
        isRestoring = true;
        await _settingsManager
            .restoreNotesFromCloud(_accountManager.currentAccount.id);
        _dialogService.alert('Your notes has been restored.',
            title: 'Restore notes');
      }
    } on AuthException {
      debugInfo('Sign in required');
      _dialogService.alert('Please relogin and try to restore again.',
          title: 'Session expired');
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

  Future<void> onUpdateTheme(bool isDarkMode) {
    final newTheme = isDarkMode ? ThemeConfig.dark : ThemeConfig.light;
    return _settingsManager.updateTheme(newTheme);
  }

  void onShowAppInfo() => _dialogService.appInfo();

  void _onSettingsChanged() => isDarkMode =
      _settingsManager.currentSettings.themeConfig == ThemeConfig.dark;
}
