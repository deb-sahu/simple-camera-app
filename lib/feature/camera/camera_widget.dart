import 'dart:async';
import 'dart:io';
import 'package:simple_camera_app/feature/gallery/gallery_page.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_camera_app/constants/common_exports.dart';
import 'package:simple_camera_app/service/singletons/camera_description_helper.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final updateClickProvider = StateProvider<bool>((ref) {
  return false;
});

class CameraWidget extends ConsumerStatefulWidget {
  const CameraWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends ConsumerState<CameraWidget> with WidgetsBindingObserver {
  // To manage the camera controller
  CameraController? controller;
  bool _isCameraInitialized = false;

  // To track the zoom level
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;

  // To track the current flash mode
  FlashMode? _currentFlashMode;

  // Set the default camera as rear camera
  bool _isRearCameraSelected = true;

  // Define a variable to store the captured image file
  File? capturedImage;
  bool isImageCaptured = false;
  Timer? thumbnailTimer;

  var cameras = CameraDescriptionHelperService().getAvailableCameras();

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }

    // Update the zoom level
    cameraController.getMaxZoomLevel().then((value) => _maxAvailableZoom = value);
    cameraController.getMinZoomLevel().then((value) => _minAvailableZoom = value);

    // Update the flash mode
    _currentFlashMode = controller!.value.flashMode;
  }


 Future<void> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }
    try { 
      XFile file = await cameraController.takePicture();
      setState(() {
        capturedImage = File(file.path); // Store the captured image
        isImageCaptured = true;
      });

      // Start a timer to hide the thumbnail after 2 seconds
      thumbnailTimer?.cancel(); // Cancel any previous timer
      thumbnailTimer = Timer(const Duration(seconds: 2), () {
        setState(() {
          capturedImage = null;
          isImageCaptured = false;
        });
      });

      File imageFile = File(file.path);

      // Get the directory for saving images based on the platform
      Directory directory;
      String fileFormat = 'jpeg';

      if (Platform.isAndroid) {
        // Android
        directory = Directory('/storage/emulated/0/Pictures');
      } else if (Platform.isIOS) {
        // iOS
        directory = await getApplicationDocumentsDirectory();
      } else {
        throw UnimplementedError("Platform not supported");
      }

      //int currentUnix = DateTime.now().millisecondsSinceEpoch;
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Copy the image to the desired directory
      String imagePath =
          '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.$fileFormat';
      await imageFile.copy(imagePath);
      
      // Update the state to show the image in the gallery
      ref.read(updateClickProvider.notifier).update((state) => true);

     // Use gallery_saver to save the image
     //GallerySaver.saveImage(imagePath);

    } catch (e) {
      if (kDebugMode) {
        print('Error occured while taking picture: $e');
      }
    }
  }

  IconData getFlashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.highlight;
      default:
        return Icons.flash_off; // Default to off if none is selected
    }
  }

  FlashMode getNextFlashMode(FlashMode currentMode) {
    switch (currentMode) {
      case FlashMode.off:
        return FlashMode.auto;
      case FlashMode.auto:
        return FlashMode.always;
      case FlashMode.always:
        return FlashMode.torch;
      case FlashMode.torch:
        return FlashMode.off;
      default:
        return FlashMode.off;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    if (cameras?.isNotEmpty == true) {
      onNewCameraSelected(cameras![0]);
    }
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    // Check the device orientation
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        
        actions: [
          IconButton(
            icon: const Icon(
              Icons.photo_library_rounded,
              color: Colors.white,
            )
            , // Icon for gallery page
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GalleryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(1.0),
        child: Stack(
          key: const Key('cameraWidget'),
          children: [
            // Container containing the camera preview
            SizedBox(
              key: const Key('cameraPreview'),
              height: height,
              width: width,
              child: _isCameraInitialized
                  ? AspectRatio(
                      aspectRatio: isLandscape
                          ? controller!.value.aspectRatio / 0.65
                          : 1 / controller!.value.aspectRatio,
                      child: controller!.buildPreview(),
                    )
                  : const Center(
                      child: Text('Camera Loading...',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
            ),
            if (isImageCaptured)
              Positioned(
                top: height * 0.02, // Adjust the position as needed
                left: width * 0.06,
                child: Image.file(
                  capturedImage!,
                  width: 80, // Adjust the size as needed
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            // Icon for flash mode
            Positioned(
              bottom: height * 0.08,
              left: width * 0.1,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _currentFlashMode = getNextFlashMode(_currentFlashMode!);
                  });
                  await controller!.setFlashMode(_currentFlashMode!);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColor.transparentBlack,
                      size: 60,
                    ),
                    Icon(
                      getFlashIcon(),
                      color: AppColor.whiteColor,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            //Toggle camera button
            Positioned(
              bottom: height * 0.08,
              right: width * 0.1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isCameraInitialized = false;
                  });
                  onNewCameraSelected(
                    cameras![_isRearCameraSelected ? 0 : 1],
                  );
                  setState(() {
                    _isRearCameraSelected = !_isRearCameraSelected;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColor.transparentBlack,
                      size: 60,
                    ),
                    Icon(
                      Icons.flip_camera_ios_rounded,
                      color: AppColor.whiteColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            // Zoom Slider
            Positioned(
              bottom: height * 0.22,
              left: width * 0.1,
              width: width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Slider(
                      value: _currentZoomLevel,
                      min: _minAvailableZoom,
                      max: _maxAvailableZoom,
                      activeColor: AppColor.blueColor,
                      inactiveColor: AppColor.whiteColor,
                      onChanged: (value) async {
                        setState(() {
                          _currentZoomLevel = value;
                        });
                        await controller!.setZoomLevel(value);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.transparentBlack,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Capture button
            Positioned(
              bottom: height * 0.025,
              width: width * 0.5,
              left: width * 0.25,
              child: InkWell(
                key: const Key('captureButton'),
                onTap: () async {
                  await takePicture();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle, color: AppColor.transparentWhite, size: 85),
                    Icon(Icons.circle, color: AppColor.whiteColor, size: 65),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
