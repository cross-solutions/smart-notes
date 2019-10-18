import 'package:app/view_models/view_models.dart';
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
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: ExtendedColumn(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ExtendedRow(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12.0,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: viewModel.currentAccount.imageUrl,
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 28.0,
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              ExtendedColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Notes',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                        child: ExtendedRow(
                          spacing: 12.0,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              elevation: 1.0,
                              backgroundColor: Colors.grey[200],
                              onPressed: viewModel.addTag,
                              child: Icon(MdiIcons.plus),
                              tooltip: 'Add Note',
                            ),
                            TagSelectorWidget(items: viewModel.tags),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
