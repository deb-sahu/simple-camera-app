import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:simple_camera_app/feature/camera/camera_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_camera_app/feature/gallery/video_player_widget.dart';
import 'package:simple_camera_app/feature/gallery/vieo_player_page.dart';
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
  List<File> photoFiles = List.empty(growable: true);
  List<File> videoFiles = List.empty(growable: true);
  List<bool> isSelected = List.empty(growable: true); // Track selection status
  bool showPhotos = true; // Toggle state

  @override
  void initState() {
    super.initState();
    loadImagesAndVideos();
  }

  Future<void> loadImagesAndVideos() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final imagesVidDir = await getApplicationDocumentsDirectory();

    // List all files in the directory
    final imageVidFiles = await imagesVidDir.list().toList();

    // Filter jpg, jpeg, and mp4 files into separate lists
    final imageFilesFiltered = imageVidFiles.whereType<File>().where((file) {
      final extension = file.path.split('.').last.toLowerCase();
      return extension == 'jpg' || extension == 'jpeg';
    }).toList();

    final videoFilesFiltered = imageVidFiles.whereType<File>().where((file) {
      final extension = file.path.split('.').last.toLowerCase();
      return extension == 'mp4';
    }).toList();

    ref.read(updateClickProvider.notifier).update((state) => false);

    setState(() {
      photoFiles = imageFilesFiltered.cast<File>();
      videoFiles = videoFilesFiltered.cast<File>();
      isSelected = List.generate(showPhotos ? photoFiles.length : videoFiles.length, (index) => false); // Initialize selection status
    });
  }

  Future<void> deletePictures(List<int> selectedIndices) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final imagesDir = await getApplicationDocumentsDirectory();
    final filesToDelete = showPhotos ? photoFiles : videoFiles;

    for (final index in selectedIndices) {
      final fileName = filesToDelete[index].path.split('/').last;
      final file = File('${imagesDir.path}/$fileName');

      try {
        // Delete the file
        await file.delete();
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

    // Reload images and videos after deleting
    loadImagesAndVideos();
  }

@override
Widget build(BuildContext context) {
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  if (ref.watch(updateClickProvider)) {
    loadImagesAndVideos();
  }

  final displayedFiles = showPhotos ? photoFiles : videoFiles;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtons(
                  isSelected: [showPhotos, !showPhotos],
                  onPressed: (index) {
                    setState(() {
                      showPhotos = index == 0;
                      isSelected = List.generate(showPhotos ? photoFiles.length : videoFiles.length, (index) => false); // Reset selection status
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Photos'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Videos'),
                    ),
                  ],
                ),
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
              final isSelectedItem = isSelected[index];
              final file = displayedFiles[index];

              return Container(
                padding: const EdgeInsets.all(0.5),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => showPhotos
                          ? PhotoViewPage(
                              photos: displayedFiles,
                              index: index,
                            )
                          : VideoPlayerPage(
                              videoFile: file,
                            ),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      showPhotos
                          ? SizedBox(
                              height: 125,
                              width: 120,
                              child: Hero(
                                tag: file.path,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 125,
                              width: 120,
                              child: Hero(
                                tag: file.path,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: VideoPlayerWidget(
                                    file: file,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        top: 8.0,
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected[index] = !isSelectedItem;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelectedItem ? Icons.check_circle_rounded : null,
                              color: isSelectedItem ? AppColor.appColor : AppColor.whiteColor,
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
            childCount: displayedFiles.length,
          ),
        ),
      ],
    ),
  );
}
}