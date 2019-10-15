import 'package:app/view_models/view_models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Semantics(
                                image: true,
                                hint: 'Profile Image',
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(viewModel.currentAccount.imageUrl),
                                  radius: 36.0,
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                              ),
                              ExtendedColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    viewModel.currentAccount.displayName,
                                    style: Theme.of(context).textTheme.title,
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
                            iconSize: 18.0,
                            icon: Icon(FontAwesomeIcons.signOutAlt),
                            onPressed: viewModel.signOut,
                            tooltip: 'Logout',
                          ),
                        ],
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
