import 'package:app/view_models/login/login_view_model.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginView extends ModelBoundWidget<LoginViewModel> {
  LoginView(LoginViewModel viewModel) : super(viewModel);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ModelBoundState<LoginView, LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<LoginViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ExtendedColumn(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32.0,
                  children: <Widget>[
                    ExtendedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24.0,
                      children: <Widget>[
                        Text(
                          'Welcome',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text('To get started, sign in using your Google Account.'),
                      ],
                    ),
                    ExtendedColumn(
                      spacing: 16.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: viewModel.signInToGoogle,
                          child: ExtendedRow(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8.0,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                size: 16.0,
                              ),
                              Text('Sign In Using Google'),
                            ],
                          ),
                        ),
                      ],
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

class GradientButton extends StatelessWidget {
  const GradientButton({
    @required this.onPressed,
    @required this.child,
    this.width = 128.0,
    Key key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      colorBrightness: Brightness.dark,
      padding: EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
      onPressed: onPressed,
      child: Container(
        height: 36.0,
        width: width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFFFE8c00),
                Color(0xFFF83600),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: child,
      ),
    );
  }
}
