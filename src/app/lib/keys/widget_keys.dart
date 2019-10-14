import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppViewKeys {
  static final view = Key(AppViewKeyValues.view);
  static final navigator = GlobalKey<NavigatorState>();
}

class MainViewKeys {
  static final view = Key(MainViewKeyValues.view);
  static final counter = Key(MainViewKeyValues.counter);
  static final incrementButton = Key(MainViewKeyValues.incrementButton);
  static final decrementButton = Key(MainViewKeyValues.decrementButton);
  static final goToSecondView = Key(MainViewKeyValues.goToSecondView);
}

class SecondViewKeys {
  static final view = Key(SecondViewKeyValues.view);
}
