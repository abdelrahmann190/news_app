import 'package:flutter/material.dart';

class ScreenDimensions {
  static getDynamicHeight(
      {required BuildContext context, required int height}) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight / (_screenHeight / height);
  }

  static getDynamicWidth({required BuildContext context, required int width}) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return _screenWidth / (_screenWidth / width);
  }
}
