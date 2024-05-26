import 'package:simple_camera_app/constants/common_exports.dart';

class AppTheme {
  // Device LIGHT theme mode
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppColor.appColor,
    ),
    scaffoldBackgroundColor: AppColor.whiteColor,
    primarySwatch: AppColor.lightThemeColors,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'FontRegular',
    textTheme: const TextTheme(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.blackColor,
      selectionColor: AppColor.grey_200,
      selectionHandleColor: AppColor.blue_750,
    ),
    primaryIconTheme: IconThemeData(color: AppColor.appColor, size: 25),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColor.appColor,
      prefixIconColor: AppColor.appColor,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      errorStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.blackColor, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.appColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.blackColor, width: 0.2),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.whiteColor,
      centerTitle: false,
      elevation: 0.0,
      iconTheme: IconThemeData(color: AppColor.appColor),
      foregroundColor: AppColor.blackColor,
      titleTextStyle: TextStyle(
        fontFamily: 'FontRegular',
        fontSize: 20,
        color: AppColor.blackColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColor.greyColor,
        elevation: 0.0,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 18, fontFamily: 'FontRegular'),
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        animationDuration: const Duration(milliseconds: 400),
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        side: BorderSide(color: AppColor.appColor, width: 0.4),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontFamily: 'FontRegular'),
        foregroundColor: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        animationDuration: const Duration(milliseconds: 400),
        elevation: 0.0,
        backgroundColor: AppColor.greyColor,
        side: BorderSide(color: AppColor.greyDarkColor, width: 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontSize: 14, fontFamily: 'FontRegular'),
        foregroundColor: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(color: AppColor.appColor),
    cardTheme: CardTheme(
      shadowColor: Colors.grey[400],
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.appColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      style: ListTileStyle.drawer,
      minLeadingWidth: 10,
      enableFeedback: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.appColor,
      selectedLabelStyle: const TextStyle(fontSize: 16),
      enableFeedback: true,
      type: BottomNavigationBarType.shifting,
      elevation: 5.0,
      selectedIconTheme: IconThemeData(color: AppColor.appColor),
      unselectedIconTheme: IconThemeData(color: AppColor.greyDarkColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: AppColor.whiteColor,
    ),
  );

  // Device DARK theme mode
  static final darkTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: AppColor.darkThemeColors,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'FontRegular',
    textTheme: const TextTheme(),
    primaryIconTheme: IconThemeData(color: AppColor.appColor, size: 25),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      iconColor: Colors.white,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      errorStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.blackColor, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.greyColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.greyColor, width: 0.2),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      foregroundColor: AppColor.whiteColor,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'FontRegular',
        fontSize: 20,
        color: AppColor.whiteColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey.withOpacity(0.4),
        elevation: 0.0,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'FontRegular',
        ),
        foregroundColor: Colors.white,
        iconColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        animationDuration: const Duration(milliseconds: 400),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(0.3),
        foregroundColor: Colors.white,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontFamily: 'FontRegular'),
        iconColor: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        animationDuration: const Duration(milliseconds: 400),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(0.3),
        side: BorderSide(color: AppColor.greyDarkColor, width: 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontSize: 14, fontFamily: 'FontRegular'),
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme: CardTheme(
      shadowColor: Colors.grey[400],
      elevation: 2.0,
      surfaceTintColor: Colors.white,
      color: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      style: ListTileStyle.drawer,
      minLeadingWidth: 10,
      enableFeedback: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontSize: 16),
      enableFeedback: true,
      type: BottomNavigationBarType.shifting,
      elevation: 5.0,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: AppColor.greyDarkColor),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: AppColor.whiteColor,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTickMarkColor: Colors.black,
      activeTrackColor: Colors.black,
      inactiveTickMarkColor: Colors.grey,
    ),
  );
}
