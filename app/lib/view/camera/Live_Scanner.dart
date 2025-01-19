import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fitnessapp/view/camera/Nutrient_display.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart' as img;

class LiveScanner extends StatefulWidget {
  @override
  _LiveScannerState createState() => _LiveScannerState();
}

class _LiveScannerState extends State<LiveScanner> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  late CameraDescription _camera;
  bool isResult = false;
  bool isProcessing = false;
  String result = "Scanning...";
  bool isCameraInitialized = false; // Flag to check if camera is initialized
  double squareSize = 200.0; // Size of the center square
  File? _croppedImage; // To hold the cropped image
  late Timer _timer; // Reference to the periodic timer

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // Initialize the camera when the widget is created
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _camera = _cameras.first; // Use the first available camera

      _controller = CameraController(_camera, ResolutionPreset.medium);
      await _controller.initialize();
      await _controller.setFlashMode(FlashMode.off);
      // Once initialization is complete, update the flag and start capturing
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }

      // Start capturing images continuously
      _startContinuousCapture();
    } catch (e) {
      setState(() {
        result = "Error initializing camera: $e";
      });
    }
  }

  // Continuously capture images and send them to the backend
  void _startContinuousCapture() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!isProcessing && !isResult) {
        setState(() {
          isProcessing = true;
        });

        // Capture an image
        final image = await _controller.takePicture();

        // Crop the center square portion
        File croppedImage = await _cropCenterSquare(File(image.path));

        // Simulate backend processing
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _croppedImage = croppedImage; // Set cropped image
            result = 'BACKEND RESULT HERE'; // Set the result text
            isProcessing = false;
            isResult = true;
          });
        });
      }
    });
  }

  Future<File> _cropCenterSquare(File image) async {
    // Load the image
    img.Image? originalImage = img.decodeImage(image.readAsBytesSync());

    if (originalImage == null) {
      setState(() {
        result = "Error reading image";
      });
      return image; // Return original image if there's an error
    }

    // Calculate the cropping area
    int cropX = (originalImage.width - squareSize).toInt() ~/ 2;
    int cropY = (originalImage.height - squareSize).toInt() ~/ 2;

    // Crop the image (corrected function signature)
    img.Image cropped = img.copyCrop(
      originalImage,
      x: cropX,
      y: cropY,
      width: squareSize.toInt(), // width
      height: squareSize.toInt(), // height
    );

    // Save the cropped image to a new file
    final croppedImageFile =
        File(image.path.replaceFirst('.jpg', '_cropped.jpg'));
    await croppedImageFile.writeAsBytes(img.encodeJpg(cropped));

    return croppedImageFile;
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the camera controller
    _timer.cancel(); // Cancel the timer to stop continuous capture
    super.dispose();
  }

    // Function to allow the user to pick a file
  Future<void> _pickImage() async {
    // Open file picker to select an image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(()async {
         File pickedFile = File(result.files.single.path!);
         final image =await _cropCenterSquare(pickedFile);
          _croppedImage= image;
      });
    } 
  }


  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust square size and other elements based on screen size
    squareSize =
        screenWidth * 0.4; // Use 40% of the screen width for the square size

    return Scaffold(
      appBar: AppBar(title: Text('Live Nutrition Label Scanner')),
      body: (isResult == false)
          ? Container(
              child: (isCameraInitialized)
                  ? Stack(
                      children: [
                        CameraPreview(_controller), // Camera feed
                        Center(
                          child: ClipPath(
                            clipper: ClippedRectangle(),
                            child: Container(
                              width: squareSize,
                              height: squareSize,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 3), // Blue border
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight*0.7,
                          width: screenWidth*0.6,
                            child: ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick an Image'),
                ),
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ), // Show loading spinner until camera is ready
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          screenWidth * 0.05), // Responsive padding
                      child: _croppedImage == null
                          ? Container()
                          : Container(
                              width: squareSize,
                              height: squareSize,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                              ),
                              child: Image.file(
                                _croppedImage!, // Display cropped image
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          screenWidth * 0.05), // Responsive padding
                      child: NutrientTable(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ClippedRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Draw a rectangle with clipped corners
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(
          20), // Adjust this to control the roundness of the corners
    ));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
