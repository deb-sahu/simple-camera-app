import 'dart:io';
import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatelessWidget {
  final List<File> photos;
  final int index;

  const PhotoViewPage({
    Key? key,
    required this.photos,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder: (context, index) => PhotoViewGalleryPageOptions.customChild(
          child: Image.file(
            photos[index],
            fit: BoxFit.cover,
          ),
          minScale: PhotoViewComputedScale.covered,
        ),
        pageController: PageController(initialPage: index),
        enableRotation: true,
      ),
    );
  }
}