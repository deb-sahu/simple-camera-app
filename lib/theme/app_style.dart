import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:simple_camera_app/feature/widget_utils/custom_top_snackbar.dart';
import 'package:flutter/cupertino.dart';

/// AppStyles class contains all the text, button and other styles.
class AppStyles {
  // Responsive Text Styles

  static TextStyle headline1(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: isPortrait
          ? MediaQuery.of(context).size.width * 0.06
          : MediaQuery.of(context).size.height * 0.08,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle headline2(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: isPortrait
          ? MediaQuery.of(context).size.width * 0.05
          : MediaQuery.of(context).size.height * 0.07,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle greyText(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: isPortrait
          ? MediaQuery.of(context).size.width * 0.04
          : MediaQuery.of(context).size.height * 0.06,
      fontWeight: FontWeight.w400,
      color: AppColor.maerskUltraDarkGrey,
    );
  }

  static TextStyle greyBoldText(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: isPortrait
          ? MediaQuery.of(context).size.width * 0.04
          : MediaQuery.of(context).size.height * 0.06,
      fontWeight: FontWeight.w700,
      color: AppColor.maerskDarkGrey,
    );
  }

  /// Returns text style for App header. Provide the context and isPortrait (bool).
  static TextStyle appHeaderTextStyle(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle loginText(BuildContext context, bool isPortrait) {
    return TextStyle(
      fontSize: isPortrait
          ? MediaQuery.of(context).size.width * 0.04
          : MediaQuery.of(context).size.height * 0.06,
    );
  }

  /// Returns text style for normal text. Provide the context.
  static TextStyle normalText(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.035,
    );
  }

  /// Returns text style for a custom text. Provide the context, color(default Black), sizeFactor(default 0.035), family(default 'MaerskText') and weight(default FontWeight.w400).
  static TextStyle customText(
    BuildContext context, {
    Color? color,
    double? sizeFactor, // MediaQuery size factor
    String? family,
    FontWeight? weight,
  }) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * (sizeFactor ?? 0.035),
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? Colors.black,
    );
  }

  // Bottom Navigation Text Styles
  static TextStyle bottomNavUnselectedText(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      fontWeight: FontWeight.w400,
      color: AppColor.blackColor,
    );
  }

  static TextStyle bottomNavSelectedText(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      fontWeight: FontWeight.w400,
      color: AppColor.maerskBlue,
    );
  }


  // Color Button Styles
  static ButtonStyle buttonDisabled = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColor.grey_600),
    backgroundColor: MaterialStateProperty.all(AppColor.whiteColor),
    side: MaterialStateProperty.all(BorderSide(
      color: AppColor.grey_600,
    )),
  );

  static ButtonStyle buttonPrimary = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColor.whiteColor),
    backgroundColor: MaterialStateProperty.all(AppColor.blue_900),
  );

  static ButtonStyle buttonSecondary = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColor.blue_900),
    backgroundColor: MaterialStateProperty.all(AppColor.whiteColor),
    side: MaterialStateProperty.all(BorderSide(
      color: AppColor.blue_900,
    )),
  );

  static ButtonStyle buttonFinal = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColor.whiteColor),
    backgroundColor: MaterialStateProperty.all(
      AppColor.red_400,
    ),
  );

  static ButtonStyle onlyTextButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppColor.blue_900),
    backgroundColor: MaterialStateProperty.all(AppColor.maerskLightGrey),
    side: MaterialStateProperty.all(BorderSide(
      color: AppColor.maerskLightGrey,
    )),
  );

  // Elevated Button Styles
  static ButtonStyle buttonPrimaryElevated = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust button height
      minimumSize: const Size(double.infinity, 48.0), // Make button full width
      textStyle: const TextStyle(fontSize: 16.0), // Adjust text size
      backgroundColor: AppColor.maerskBlue,
      foregroundColor: AppColor.whiteColor);

  // Top Snackbars Styles
  static void showInfo(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    CustomTopSnackbar.show(
      context,
      message,
      leadingIcon: CupertinoIcons.info_circle_fill,
      duration: duration,
    );
  }

  static void showSuccess(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    CustomTopSnackbar.show(
      context,
      message,
      backgroundColor: AppColor.maerskSuccessGreenLight,
      borderColor: AppColor.whiteColor,
      textColor: AppColor.maerskSuccessGreen,
      leadingIcon: CupertinoIcons.checkmark_alt_circle_fill,
      duration: duration,
    );
  }

  static void showError(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    CustomTopSnackbar.show(
      context,
      message,
      backgroundColor: AppColor.maerskErrorRedLight,
      borderColor: AppColor.whiteColor,
      textColor: AppColor.maerskErrorRed,
      leadingIcon: CupertinoIcons.exclamationmark_triangle_fill,
      duration: duration,
    );
  }


}
