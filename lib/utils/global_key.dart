import 'package:flutter/material.dart';

MyGlobals myGlobals = MyGlobals(scaffoldKey: GlobalKey());

class MyGlobals {
  final GlobalKey scaffoldKey;
  MyGlobals({required this.scaffoldKey});
}
