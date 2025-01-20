import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fitnessapp/utils/api.dart';
import 'package:fitnessapp/utils/app_colors.dart';
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

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final userViewModel = GetIt.instance<
      UserViewModel>(); // UserViewModel passed to the constructor
late final List<UserViewModel> userList;
  bool positive = false;

void InitState()async{
  try {
  final response = await Api.getAllCustomers();
  userList=response;
  }
  catch(e){

  }
}

  List<Map<String, dynamic>> accountArr = [
    {
      "image": "assets/icons/p_personal.png",
      "name": "Personal Data",
      "tag": "1",
      "weight": "65kg", // Added weight
      "height": "180cm", // Added height
      "age": "22yo",
      "Len": 0,
    },
    {
      "image": "assets/icons/p_activity.png",
      "name": "Disease History",
      "tag": "3",
      "Len": 2,
      "additionalData": [
        "Diabetes",
        "Malaria"
      ], // List<String?>, no change needed
    },
    {
      "image": "assets/icons/p_workout.png",
      "name": "Health Complications",
      "tag": "4",
      "Len": 2,
      "additionalData": [
        "Thyroid",
        "Lactose Intolerant"
      ], // List<String?>, no change needed
    }
  ];

  
  @override
  Widget build(BuildContext context) {
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
              height: screenWidth * 0.1, // Adjust size dynamically
              width: screenWidth * 0.1, // Adjust size dynamically
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/icons/more_icon.png",
                width: screenWidth * 0.05, // Adjust size dynamically
                height: screenWidth * 0.05, // Adjust size dynamically
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.015, horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/images/user.png",
                      width: screenWidth * 0.12, // Adjust size dynamically
                      height: screenWidth * 0.12, // Adjust size dynamically
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tithi", // Display user's name
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: screenWidth *
                                0.035, // Adjust font size dynamically
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Lose a Fat Program", // Placeholder text, could be dynamic later
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: screenWidth *
                                0.03, // Adjust font size dynamically
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.4, // Adjust width dynamically
                    height: screenHeight * 0.05, // Adjust height dynamically
                    child: RoundButton(
                      title: "Click on > to Edit",
                      type: RoundButtonType.primaryBG,
                      onPressed: () {
                        // Implement the edit functionality
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "Male", // User's weight
                      subtitle: "Gender",
                    ),
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${userViewModel.height}cm", // User's height
                      subtitle: "Height",
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${userViewModel.weight}kg", // User's weight
                      subtitle: "Weight",
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${userViewModel.age}yo", // User's age
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.04),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize:
                            screenWidth * 0.04, // Adjust font size dynamically
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Convert ListView.builder to Column
                    ...accountArr.map((iObj) {
                      return SettingRow(
                        len: iObj['Len'],
                        additionalData: iObj['additionalData'] ?? [],
                        icon: iObj["image"].toString(),
                        title: iObj["name"].toString(),
                        onPressed: () {
                          if (iObj["tag"] == "1") {
                            // Handle "Personal Data" button press
                          } else if (iObj["tag"] == "3") {
                            // Handle "Activity History" button press
                          } else if (iObj["tag"] == "4") {
                            // Handle "Workout Progress" button press
                          }
                        },
                      );
                    }).toList(), // Convert map into a list of widgets
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.04),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize:
                            screenWidth * 0.04, // Adjust font size dynamically
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      height: screenHeight * 0.06, // Adjust height dynamically
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/p_notification.png",
                              height:
                                  screenWidth * 0.05, // Adjust size dynamically
                              width:
                                  screenWidth * 0.05, // Adjust size dynamically
                              fit: BoxFit.contain),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Text(
                              "Pop-up Notification",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: screenWidth *
                                    0.035, // Adjust font size dynamically
                              ),
                            ),
                          ),
                          CustomAnimatedToggleSwitch<bool>(
                            current: positive,
                            values: [false, true],
                            dif: 0.0,
                            indicatorSize: Size.square(
                                screenWidth * 0.08), // Adjust size dynamically
                            animationDuration:
                                const Duration(milliseconds: 200),
                            animationCurve: Curves.linear,
                            onChanged: (b) => setState(() => positive = b),
                            iconBuilder: (context, local, global) {
                              return const SizedBox();
                            },
                            defaultCursor: SystemMouseCursors.click,
                            onTap: () => setState(() => positive = !positive),
                            iconsTappable: false,
                            wrapperBuilder: (context, global, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      left: screenWidth *
                                          0.02, // Adjust size dynamically
                                      right: screenWidth *
                                          0.02, // Adjust size dynamically
                                      height: screenHeight *
                                          0.05, // Adjust size dynamically
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: AppColors.secondaryG),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30.0)),
                                        ),
                                      )),
                                  child,
                                ],
                              );
                            },
                            foregroundIndicatorBuilder: (context, global) {
                              return SizedBox.fromSize(
                                size: Size(
                                    screenWidth * 0.03,
                                    screenWidth *
                                        0.03), // Adjust size dynamically
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 0.05,
                                          blurRadius: 1.1,
                                          offset: Offset(0.0, 0.8))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
