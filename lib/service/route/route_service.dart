import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_camera_app/feature/camera/camera_widget.dart';
import 'package:simple_camera_app/feature/gallery/gallery_page.dart';
import 'package:simple_camera_app/feature/home/home.dart';
import 'bottom_nav_route.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/', // Set initial location to login page
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const NavRoute(); // Default route, redirects to home page
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'homePage',
          builder: (BuildContext context, GoRouterState state) {
            return const Home(); // Home page route
          },
        ),
        GoRoute(
          path: 'cameraPage',
          builder: (BuildContext context, GoRouterState state) {
            return const CameraWidget(); // Camera page route
          },
        ),
        GoRoute(
          path: 'galleryPage',
          builder: (BuildContext context, GoRouterState state) {
            return const GalleryPage(); // Gallery page route
          },
        ),
      ],
    ),
  ],
);
