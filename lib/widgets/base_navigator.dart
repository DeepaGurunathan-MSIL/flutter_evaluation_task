
import 'package:flutter/cupertino.dart';

import '../model/arguments.dart';

class BaseNavigator {
  BuildContext context;
  Arguments? arguments;
  String? route;
  BaseNavigator(this.context, {this.arguments, this.route});

  void navigatorPush(){
    Navigator.pushNamed(context,route!,arguments: arguments);

  }
  void navigatorPop(){
    Navigator.pop(context);
  }

  void navigatorPushAndRemoveUntil(){
    Navigator.of(context).pushNamedAndRemoveUntil(route!, (Route<dynamic> route) => false);
  }
}