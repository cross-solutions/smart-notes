import 'package:app/resources/resources.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.im_logo_128),
      ),
    );
  }
}
