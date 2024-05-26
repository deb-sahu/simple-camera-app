import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var height = AppLayouts.viewHeight(context);
    var width = AppLayouts.viewWidth(context);
    bool isPortrait = AppLayouts.isPortraitMode(context);

    return Scaffold(
      backgroundColor: AppColor.maerskLightGrey,
      appBar: AppBar(
        toolbarHeight: AppLayouts.appBarHeight(context),
        automaticallyImplyLeading: false,
        actions: const [],
        title: Text(
          'Home',
          style: AppStyles.appHeaderTextStyle(context, isPortrait),
        ),
      ),
      floatingActionButton: SizedBox(
        height: AppLayouts.fabSize(context),
        width: AppLayouts.fabSize(context),
        child:
      FloatingActionButton(
        onPressed: () {
         
        },
        backgroundColor: AppColor.appColor,
        splashColor: AppColor.maerskLightBlue,
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          CupertinoIcons.add,
          size: AppLayouts.iconSize(context), 
        ),
      ),),
      body: SafeArea(
        minimum: EdgeInsets.all(width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Page',
              style: AppStyles.customText(context, color: AppColor.appColor),
              textAlign: TextAlign.start,
            ),
 
          ],
        ),
      ),
    );
  }
}
