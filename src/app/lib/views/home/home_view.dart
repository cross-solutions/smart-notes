import 'package:app/models/list_editing_mode.dart';
import 'package:app/resources/resources.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/views/home/notes_list_view.dart';
import 'package:app/views/home/tag_selector_widget.dart';
import 'package:app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeView extends ModelBoundWidget<HomeViewModel> {
  HomeView(HomeViewModel viewModel) : super(viewModel);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ModelBoundState<HomeView, HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<HomeViewModel>(
        builder: (context, child, viewModel) {
          final isDeleting = viewModel.editingMode == ListEditingMode.delete;
          return WillPopScope(
            onWillPop: () async {
              viewModel.onToggleEditingMode();
              return !isDeleting;
            },
            child: Scaffold(
              appBar: _buildAppBar(isDeleting),
              body: _buildBody(isDeleting),
              floatingActionButton: _buildFloatingActionButton(isDeleting),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(bool isDeleting) {
    return PreferredSize(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 250),
            firstCurve: Curves.easeOutSine,
            secondCurve: Curves.easeOutSine,
            crossFadeState: isDeleting ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ExtendedRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.0,
                  children: <Widget>[
                    SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: CachedNetworkImage(
                        imageUrl: viewModel.currentAccount.imageUrl,
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 28.0,
                            backgroundColor: Theme.of(context).primaryColor,
                          );
                        },
                        placeholder: (context, url) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    ExtendedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          viewModel.currentAccount.name,
                          style: Theme.of(context).textTheme.body2,
                        ),
                        Text(
                          viewModel.currentAccount.email,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(MdiIcons.logout),
                  onPressed: viewModel.signOut,
                  tooltip: 'Logout',
                ),
              ],
            ),
            secondChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ExtendedRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.0,
                  children: <Widget>[
                    SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: viewModel.onToggleEditingMode,
                      ),
                    ),
                    Text(
                      'Selected ${viewModel.selectedNotesCount} note/s',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
                ExtendedRow(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.0,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.select_all),
                      onPressed: viewModel.onToggleSelectAllNotes,
                      tooltip: 'Select All',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: viewModel.onDeleteSelectedNotes,
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      preferredSize: Size(double.infinity, 120),
    );
  }

  Widget _buildFloatingActionButton(bool isDeleting) {
    if (isDeleting)
      return null;
    else
      return FloatingActionButton(
        onPressed: viewModel.onAddNote,
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: const BoxDecoration(
            gradient: AppGradients.orangeAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(28.0),
            ),
          ),
          child: Icon(MdiIcons.plus),
        ),
        tooltip: 'Add Note',
      );
  }

  Widget _buildBody(bool isDeleting) {
    return ExtendedColumn(
      spacing: 16.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IgnorePointer(
          ignoring: isDeleting,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeOutSine,
            opacity: isDeleting ? 0.18 : 1.0,
            child: ExtendedColumn(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildNotesTitle(),
                _buildTagsSelectionWidget(),
              ],
            ),
          ),
        ),
        Expanded(child: NotesListView()),
      ],
    );
  }

  Widget _buildNotesTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Notes',
            style: Theme.of(context).textTheme.headline,
          ),
          FlatButton(
            colorBrightness: Theme.of(context).brightness,
            child: ExtendedRow(
              spacing: 8.0,
              children: <Widget>[
                Icon(
                  Icons.mode_edit,
                  size: 16.0,
                ),
                Text(
                  'Tags',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildTagsSelectionWidget() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: ExtendedRow(
          spacing: 12.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TagSelectorWidget(items: viewModel.tags),
          ],
        ),
      ),
    );
  }
}
