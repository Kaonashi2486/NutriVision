import 'package:fitnessapp/utils/api.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/round_gradient_button.dart';
import '../../common_widgets/round_textfield.dart';
import '../profile/complete_profile_screen.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/SignupScreen";

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;

  // Controller for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Method to handle registration
  Future<void> _registerUser() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
          AlertDialog(title:Text( "Pls fill in all the fields"));

      return;
    }

    UserViewModel userViewModel = UserViewModel(
      name: firstNameController.text,
      lName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      contactNumber: "", // Optional, if needed
      address: "", // Optional, if needed
      city: "", // Optional, if needed
      role: "customer", // As per your model
      createdAt: DateTime.now(),
      healthIssues: {},
      allergies: [],
      foodPreference: "veg", // Optional, default value
      familymembers: [],
    );

    try {
      final response = await Api.register(userViewModel);

      // If registration is successful, navigate to the complete profile screen
       Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteProfileScreen(userViewModel: userViewModel)
           ),
           );
    } catch (error) {
      // If registration fails, show an error message
      AlertDialog(title:Text( "Unsucessful login"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  "Hey there,",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  "Create an Account",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
                RoundTextField(
                  textEditingController: firstNameController,
                  hintText: "First Name",
                  icon: "assets/icons/profile_icon.png",
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 15),
                RoundTextField(
                  textEditingController: lastNameController,
                  hintText: "Last Name",
                  icon: "assets/icons/profile_icon.png",
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 15),
                RoundTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: "assets/icons/message_icon.png",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                RoundTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: "assets/icons/lock_icon.png",
                  textInputType: TextInputType.text,
                  isObscureText: true,
                  rightIcon: TextButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/icons/hide_pwd_icon.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outline_blank_outlined
                            : Icons.check_box_outlined,
                        color: AppColors.grayColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "By continuing you accept our Privacy Policy and\nTerm of Use",
                        style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                RoundGradientButton(
                  title: "Register",
                  onPressed: _registerUser, // Trigger the registration
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: 1,
                        color: AppColors.grayColor.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "  Or  ",
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: 1,
                        color: AppColors.grayColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primaryColor1.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          "assets/icons/google_icon.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primaryColor1.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          "assets/icons/facebook_icon.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                        ),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: AppColors.secondaryColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
