import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  MyInheritedWidget({
    //required Key key,
    required Widget child,
    @required this.data,
  }) : super(child: child);

  final dynamic data;

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return true;
  }
}
