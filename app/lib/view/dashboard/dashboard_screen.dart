import 'dart:io';
import 'package:fitnessapp/view/camera/Live_Scanner.dart';
import 'package:fitnessapp/view/chatBot/chatBot.dart';
import 'package:fitnessapp/view/profile/overall_profiles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/activity/activity_screen.dart';
import 'package:fitnessapp/view/camera/camera_screen.dart';
import 'package:fitnessapp/view/profile/user_profile.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/DashboardScreen";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectTab = 0;

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      // Handle permission denial, show a message, or redirect user to settings
      print("Camera permission denied.");
    }
  }

  File? _image; // Variable to store the image for further processing

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the camera
  Future<void> _pickImage() async {
    // Request camera permission before proceeding
    await requestCameraPermission();

    // Open the camera and capture an image
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path); // Save the captured image
      });
    } else {
      // Handle if the user cancels the capture
      print("No image selected");
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
     LiveScanner(),
    const CameraScreen(),
    const Overall_User_Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: IndexedStack(
        index: selectTab,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomAppBar(
        height: Platform.isIOS ? 70 : 65,
        color: Colors.transparent,
        padding: const EdgeInsets.all(0),
        child: Container(
          height: Platform.isIOS ? 70 : 65,
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                  icon: "assets/icons/home_icon.png",
                  selectIcon: "assets/icons/home_select_icon.png",
                  isActive: selectTab == 0,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 0;
                      });
                    }
                  }),
              TabButton(
                  icon: "assets/icons/activity_icon.png",
                  selectIcon: "assets/icons/activity_select_icon.png",
                  isActive: selectTab == 1,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 1;
                      });
                    }
                  }),
  
              TabButton(
                icon: "assets/icons/camera_icon.png",
                selectIcon: "assets/icons/camera_select_icon.png",
                isActive: selectTab == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
              TabButton(
                  icon: "assets/icons/user_icon.png",
                  selectIcon: "assets/icons/user_select_icon.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 3;
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String icon;
  final String selectIcon;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton(
      {Key? key,
      required this.icon,
      required this.selectIcon,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isActive ? selectIcon : icon,
            width: 25,
            height: 25,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: isActive ? 8 : 12),
          Visibility(
            visible: isActive,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.secondaryG),
                  borderRadius: BorderRadius.circular(2)),
            ),
          )
        ],
      ),
    );
  }
}
