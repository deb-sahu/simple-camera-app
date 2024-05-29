import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_camera_app/service/singletons/camera_description_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'app_container.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
    CameraDescriptionHelperService().setAvailableCameras(cameras);
    await requestPermissions([
      Permission.storage,
      Permission.camera,
      Permission.photos,
      Permission.mediaLibrary,
      // Add more permissions here as needed.
    ]);
  } on Exception catch (e) {
    // ignore: avoid_print
    print('Error in fetching required permissions: $e');
  }

  HttpOverrides.global = MyHttpOverrides();
/*   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */

  // Uncomment the line below to enable device preview
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => const AIMobileInspection()));

  // Uncomment the line below to disable device preview
  runApp( const ProviderScope(
    child: SimpleCamApp()));
}

Future<void> requestPermissions(List<Permission> permissions) async {
  for (final permission in permissions) {
    final permissionStatus = await permission.status;
    if (permissionStatus.isDenied) {
      await permission.request();
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
