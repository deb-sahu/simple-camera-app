import 'package:simple_camera_app/service/route/route_service.dart';
import 'package:simple_camera_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SimpleCamApp extends StatefulWidget {
  const SimpleCamApp({Key? key}) : super(key: key);
  @override
  State<SimpleCamApp> createState() => _SimpleCamAppState();
}

class _SimpleCamAppState extends State<SimpleCamApp> {
  Locale? _locale;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Simple Camera App',
      debugShowCheckedModeBanner: false,
      //checkerboardOffscreenLayers: true,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('zh', ''),
      ],
      localizationsDelegates: _getLocalizationsDelegates(),
      localeResolutionCallback: (locale, supportedLocales) => _getLocale(locale, supportedLocales),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      builder: EasyLoading.init(),
      routerConfig: router,
    );
  }

  List<LocalizationsDelegate> _getLocalizationsDelegates() {
    return [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }

  Locale _getLocale(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
