import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/on_boarding/on_boarding_screen.dart';
import 'package:fitnessapp/view/profile/user_profile.dart';
import 'package:fitnessapp/view/profile/widgets/setting_row.dart';
import 'package:fitnessapp/view/profile/widgets/title_subtitle_cell.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../../common_widgets/round_button.dart';
import 'package:fitnessapp/view_models/user_view_model.dart';

// Temporary ViewModel Classes for Activity and Workout Progress
class ActivityViewModel {
  // Add activity-related fields
}

class WorkoutProgressViewModel {
  // Add workout-related fields
}

class Overall_User_Profile extends StatefulWidget {
  const Overall_User_Profile({Key? key}) : super(key: key);

  @override
  State<Overall_User_Profile> createState() => _OverallUserProfile();
}

class _OverallUserProfile extends State<Overall_User_Profile> {
  final userViewModel = GetIt.instance<
      UserViewModel>(); // UserViewModel passed to the constructor

  bool positive = false;

  List accountArr = [
    {
      "image": "assets/icons/p_personal.png",
      "name": "Personal Data",
      "tag": "1",
      "weight": "65kg", // Added weight
      "height": "180cm", // Added height
      "age": "22yo", // Added age
      "Len": 1,
      "additionalData": ["temp"]
    },
    {
      "image": "assets/icons/p_activity.png",
      "name": "Activity History",
      "tag": "3",
      "Len": 4,
      "additionalData": [
        "Morning Jog",
        "Yoga",
        "Weight Lifting",
        "Cycling"
      ], // Added list of activities
    },
    {
      "image": "assets/icons/p_workout.png",
      "name": "Workout Progress",
      "tag": "4",
      "Len": 3,
      "additionalData": [
        "Nutrient Requirement",
        "Track",
        "Untracked"
      ], // Added list for workout progress items
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Getting screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/icons/more_icon.png",
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: screenWidth *
                  0.05), // using MediaQuery for horizontal padding
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 5, 0, 25),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Family Profiles',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            screenWidth * 0.05), // Dynamically set font size
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/user.png",
                          width: screenWidth *
                              0.15, // Adjust width based on screen size
                          height: screenWidth *
                              0.15, // Adjust height based on screen size
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          width: screenWidth *
                              0.05), // Adjust width based on screen size
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userViewModel.name, // Display user's name
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize:
                                    screenWidth * 0.035, // Adjust font size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Lose a Fat Program", // Placeholder text, could be dynamic later
                              style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize:
                                    screenWidth * 0.03, // Adjust font size
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                            screenWidth * 0.2, // Adjust width for button size
                        height: screenHeight *
                            0.04, // Adjust height based on screen size
                        child: RoundButton(
                          title: "Edit",
                          type: RoundButtonType.primaryBG,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/user.png",
                          width: screenWidth *
                              0.15, // Adjust width based on screen size
                          height: screenWidth *
                              0.15, // Adjust height based on screen size
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          width: screenWidth *
                              0.05), // Adjust width based on screen size
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userViewModel.name, // Display user's name
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize:
                                    screenWidth * 0.035, // Adjust font size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Lose a Fat Program", // Placeholder text, could be dynamic later
                              style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize:
                                    screenWidth * 0.03, // Adjust font size
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                            screenWidth * 0.2, // Adjust width for button size
                        height: screenHeight *
                            0.04, // Adjust height based on screen size
                        child: RoundButton(
                          title: "Edit",
                          type: RoundButtonType.primaryBG,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                    screenWidth * 0.05), // Adjust padding based on screen width
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 5, 0, 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBordingScreen()),
                      );
                    },
                    child: SizedBox(
                      width: screenWidth *
                          0.1, // Adjust width based on screen width
                      height: screenWidth *
                          0.1, // Adjust height based on screen width
                      child: Container(
                        width: screenWidth * 0.1, // Adjust width dynamically
                        height: screenWidth * 0.1, // Adjust height dynamically
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: AppColors.primaryG),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 2)
                            ]),
                        child: const Icon(Icons.add,
                            color: AppColors.whiteColor, size: 30),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
