import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:flutter/cupertino.dart';

/// AppLayouts class contains all the responsive media query functions.
class AppLayouts {
  // Responsive Media Query functions

  /// Returns the height(double) of the current view. Provide the context.
  static double viewHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  /// Returns the width(double) of the current view. Provide the context.
  static double viewWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  /// Returns a boolean value if the current orientation is portrait. Provide the context. True if portrait, false if landscape.
  static bool isPortraitMode(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
  /// Returns a boolean value if the current orientation is landscape. Provide the context. True if landscape, false if portrait.
  static bool isLandscapeMode(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  /// Returns the size(double) of the icon. Provide the context.
  static double iconSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.03;
  }
  /// Returns the app bar height(double). Provide the context.
  static double appBarHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }
  /// Returns the icon size(double) in the app bar. Provide the context.
  static double appIconSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.05;
  }
  /// Returns the size(double) of the floating action button. Provide the context.
  static double fabSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.07;
  }
}
