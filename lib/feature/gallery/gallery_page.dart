import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:simple_camera_app/feature/camera/camera_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'full_screen_view_page.dart';

class GalleryPage extends ConsumerStatefulWidget {
  const GalleryPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends ConsumerState<GalleryPage> {
  List<File> photos = List.empty(growable: true);
  List<bool> isSelected = List.empty(growable: true); // Track selection status

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final imagesDir = Directory('/storage/emulated/0/Pictures'); // Load images from Pictures directory

    final imageFiles = await imagesDir.list().toList();
    final imageFilesFiltered = imageFiles.whereType<File>().toList();
    ref.read(updateClickProvider.notifier).update((state) => false);

    setState(() {
      photos = imageFilesFiltered.cast<File>();
      isSelected = List.generate(photos.length, (index) => false); // Initialize selection status
    });
  }

  Future<void> deletePictures(List<int> selectedIndices) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final imagesDir = Directory('/storage/emulated/0/Pictures');

    for (final index in selectedIndices) {
      final fileName = photos[index].path.split('/').last;
      final imageFile = File('${imagesDir.path}/$fileName');

      try {
        // Delete the file
        await imageFile.delete();
      } catch (e) {
        // Handle any errors that may occur during the file operation
        if (e is FileSystemException) {
          // Show a snackbar with the error message
          // ignore: use_build_context_synchronously
          AppStyles.showError(
            // ignore: use_build_context_synchronously
            context,
            'Error deleting file',
          );
        }
      }
    }

    // Reload images after deleting
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    // Check the device orientation
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

     if (ref.watch(updateClickProvider)) {
      loadImages();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Gallery',
              style: TextStyle(
                color: AppColor.whiteColor,
              ),
            ),
            backgroundColor: AppColor.appColor,
            elevation: 2.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColor.whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColor.whiteColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraWidget(),
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            key: const Key('galleryWidget'),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: AppColor.appColor,
                    ),
                    onPressed: () {
                      final selectedIndices = isSelected
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();
                      if (selectedIndices.isNotEmpty) {
                        deletePictures(selectedIndices);
                      }        
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 6 : 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final isSelectedImage = isSelected[index];
                return Container(
                  padding: const EdgeInsets.all(0.5),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoViewPage(
                          photos: photos,
                          index: index,
                        ),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 125,
                          width: 120,
                          child: Hero(
                              tag: photos[index].path,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  photos[index],
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        Positioned(
                          top: 8.0,
                          right: 10.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected[index] = !isSelectedImage;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isSelectedImage
                                    ? Icons.check_circle_rounded
                                    : null,
                                color: isSelectedImage 
                                    ? AppColor.appColor
                                    : AppColor.whiteColor,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: photos.length,
            ),
          ),
        ],
      ),
    );
  }
}
