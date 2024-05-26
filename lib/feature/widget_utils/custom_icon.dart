import 'package:simple_camera_app/constants/common_exports.dart';

class CustomIcon extends StatelessWidget {
  final String? selectedAssetPath;
  final String? unselectedAssetPath;
  final IconData? selectedIcon;
  final IconData? unselectedIcon;
  final bool isSelected;

  const CustomIcon({
   this.selectedAssetPath,
   this.unselectedAssetPath,
   this.selectedIcon,
   this.unselectedIcon,
   required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedAssetPath != null && unselectedAssetPath != null) {
      return SvgPicture.asset(
        isSelected ? selectedAssetPath! : unselectedAssetPath!,
        height: AppLayouts.iconSize(context),
        width: AppLayouts.iconSize(context),
        color: isSelected ? AppColor.appColor : AppColor.blackColor,
      );
    } else if (selectedIcon != null && unselectedIcon != null) {
      return Icon(
        isSelected ? selectedIcon : unselectedIcon,
        size: AppLayouts.iconSize(context),
        color: isSelected ? AppColor.appColor : AppColor.blackColor,
      );
    } else {
      // Handle invalid input or return a default widget
      return Container();
    }
  }
}
