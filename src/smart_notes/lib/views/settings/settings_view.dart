import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsView extends ModelBoundWidget<SettingsViewModel> {
  SettingsView(SettingsViewModel viewModel) : super(viewModel);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState
    extends ModelBoundState<SettingsView, SettingsViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SettingsViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<SettingsViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SwitchListTile(
                  value: viewModel.isDarkMode ?? false,
                  onChanged: viewModel.onUpdateTheme,
                  title: Text('Dark Mode'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Account and Syncing',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                ListTile(
                  title: Text('Restore your data'),
                  subtitle: Text('Download your data from a previous backup'),
                  onTap: viewModel.onRestoreNotes,
                  trailing: viewModel.isRestoring
                      ? Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          width: 40.0,
                          height: 24.0,
                          child: CircularProgressIndicator(),
                        )
                      : null,
                ),
                ListTile(
                  title: Text('Backup your data'),
                  subtitle: Text('Export and save your current data'),
                  onTap: viewModel.onBackupNotes,
                  trailing: viewModel.isBackuping
                      ? Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          width: 40.0,
                          height: 24.0,
                          child: CircularProgressIndicator(),
                        )
                      : null,
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: viewModel.onSignOut,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Application',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                ListTile(
                  title: Text('About Smart Notes'),
                  subtitle: Text('View app info and open source licenses'),
                  onTap: viewModel.onShowAppInfo,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
