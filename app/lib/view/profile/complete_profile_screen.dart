import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/your_goal/your_goal_screen.dart';
import 'package:fitnessapp/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/round_gradient_button.dart';
import '../../common_widgets/round_textfield.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/CompleteProfileScreen";
  
  // Receive UserViewModel as constructor parameter
  final UserViewModel userViewModel;
  
  const CompleteProfileScreen({Key? key, required this.userViewModel}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController eatingPrefController = TextEditingController();
  final TextEditingController healthComplicationsController = TextEditingController();

  String? gender;
  
  // Method to handle updating the profile (update the UserViewModel)
  void _updateProfile() {
    if (dobController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty ||
        eatingPrefController.text.isEmpty) {
      // Show a toast or snackbar for empty fields
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all fields")));
      return;
    }

    // Update the UserViewModel with the new data
    widget.userViewModel.weight =  double.parse(weightController.text);
    widget.userViewModel.height = double.parse(heightController.text);
    widget.userViewModel.gender = gender ?? widget.userViewModel.gender;
    widget.userViewModel.isPregnant = gender == "female" ? false : null;
    widget.userViewModel.foodPreference = eatingPrefController.text.isEmpty ? "veg" : eatingPrefController.text;
    widget.userViewModel.healthIssues = healthComplicationsController.text.isEmpty ? {} : {"health_issues": healthComplicationsController.text};

    // After updating, navigate to the next page
    Navigator.pushNamed(context, YourGoalScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              children: [
                Image.asset("assets/images/complete_profile.png", width: media.width),
                SizedBox(height: 15),
                Text("Let’s complete your profile", style: TextStyle(color: AppColors.blackColor, fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 5),
                Text("It will help us to know more about you!", style: TextStyle(color: AppColors.grayColor, fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w400)),
                SizedBox(height: 25),
                // Gender Dropdown
                Container(
                  decoration: BoxDecoration(color: AppColors.lightGrayColor, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("assets/icons/gender_icon.png", width: 20, height: 20, fit: BoxFit.contain, color: AppColors.grayColor)),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: ["Male", "Female"].map((name) {
                              return DropdownMenuItem(
                                value: name,
                                child: Text(name, style: TextStyle(color: AppColors.grayColor, fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            isExpanded: true,
                            hint: Text("Choose Gender", style: TextStyle(color: AppColors.grayColor, fontSize: 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                // Date of Birth
                RoundTextField(
                  textEditingController: dobController,
                  hintText: "Date of Birth",
                  icon: "assets/icons/calendar_icon.png",
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                // Weight
                RoundTextField(
                  textEditingController: weightController,
                  hintText: "Your Weight",
                  icon: "assets/icons/weight_icon.png",
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                // Height
                RoundTextField(
                  textEditingController: heightController,
                  hintText: "Your Height",
                  icon: "assets/icons/swap_icon.png",
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                // Eating Preference
                RoundTextField(
                  textEditingController: eatingPrefController,
                  hintText: "Enter your eating pref (Jain, Veg or Non-Veg)",
                  icon: Icons.emoji_food_beverage_sharp,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                // Health Complications
                RoundTextField(
                  textEditingController: healthComplicationsController,
                  hintText: "Enter any Health Complications",
                  icon: Icons.health_and_safety,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                // Next Button
                RoundGradientButton(
                  title: "Next >",
                  onPressed: _updateProfile, // Update UserViewModel and go to next screen
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
