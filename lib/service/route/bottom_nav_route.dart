import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:simple_camera_app/feature/gallery/gallery_page.dart';
import 'package:simple_camera_app/feature/home/home.dart';
import 'package:simple_camera_app/feature/widget_utils/custom_icon.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/camera/camera_widget.dart';
final bottomNavIndexProvider = StateProvider((ref) => 0);
class NavRoute extends ConsumerWidget {
 const NavRoute({super.key});
  
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const CameraWidget(),
    const GalleryPage()
    // Add your other page widgets here
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: CustomIcon(
            selectedIcon: CupertinoIcons.house_alt_fill,
            unselectedIcon: CupertinoIcons.house_alt,
            isSelected: currentIndex == 0,
          ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(
            selectedIcon: CupertinoIcons.camera_fill,
            unselectedIcon: CupertinoIcons.camera,
            isSelected: currentIndex == 1
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(
            selectedIcon: CupertinoIcons.photo_fill_on_rectangle_fill,
            unselectedIcon: CupertinoIcons.photo_on_rectangle,
            isSelected: currentIndex == 2
            ),
            label: 'Gallery',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: AppColor.appColor,
        unselectedItemColor: AppColor.blackColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppStyles.bottomNavSelectedText(context), 
        unselectedLabelStyle: AppStyles.bottomNavUnselectedText(context), 
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).update((state) => index);
        },
      ),
    );
  }
}
 