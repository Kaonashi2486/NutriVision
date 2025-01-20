import 'package:fitnessapp/common_widgets/dot_indicator.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/on_boarding/widgets/On_boarding_Content.dart';
import 'package:fitnessapp/view/on_boarding/widgets/pager_widget.dart';
import 'package:fitnessapp/view/signup/signup_screen.dart';
import 'package:flutter/material.dart';

// class OnBoardingScreen extends StatefulWidget {
//   static String routeName = "/OnBoardingScreen";
//   const OnBoardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   PageController pageController = PageController();
//   List pageList = [
//     {
//       "title": "Track Your Goal",
//       "subtitle":
//           "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
//       "image": "assets/images/on_board1.png"
//     },
//     {
//       "title": "Get Burn",
//       "subtitle":
//           "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
//       "image": "assets/images/on_board2.png"
//     },
//     {
//       "title": "Eat Well",
//       "subtitle":
//           "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
//       "image": "assets/images/on_board3.png"
//     },
//     {
//       "title": "Improve Sleep Quality",
//       "subtitle":
//           "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
//       "image": "assets/images/on_board4.png"
//     }
//   ];
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           PageView.builder(
//             controller: pageController,
//             itemCount: pageList.length,
//             onPageChanged: (i) {
//               setState(() {
//                 selectedIndex = i;
//               });
//             },
//             itemBuilder: (context, index) {
//               var temp = pageList[index] as Map? ?? {};
//               return PagerWidget(obj: temp);
//             },
//           ),
//           SizedBox(
//             width: 120,
//             height: 120,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 70,
//                   height: 70,
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor1,
//                     value: (selectedIndex+1) / 4,
//                     strokeWidth: 3,
//                   ),
//                 ),
//                 Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(35),
//                       color: AppColors.primaryColor1),
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.navigate_next,
//                       color: AppColors.whiteColor,
//                     ),
//                     onPressed: () {
//                       if (selectedIndex < 3) {
//                         selectedIndex = selectedIndex + 1;
//                         pageController.animateToPage(selectedIndex,
//                             duration: const Duration(milliseconds: 700),
//                             curve: Curves.easeInSine);
//                       }
//                       else{
//                         Navigator.pushNamed(context, SignupScreen.routeName);
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class OnBordingScreen extends StatefulWidget {
  static String routeName = "/OnBoardingScreen";

  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController _pageController;
  final Text_controller = TextEditingController();
  int _pageIndex = 0;

  final List<Onbord> _onbordData = [
    Onbord(
        image: "assets/images/weight.jpg",
        title: "Get A Quick Analysis of your health",
        description:
            "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
        question:
            "What is your body weight and Height?", // Health-related question
        preText: "Height:\nWeight:"),
    Onbord(
      image: "assets/images/incredient.jpeg",
      title: "Get A quick Analysis of food you consume",
      description:
          "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
      question:
          "Do you have any health conditions?", // Another health-related question
    ),

    Onbord(
      image: "assets/images/Food_chatbot.jpeg",
      title: "Food Chatbot for your queries",
      description: "There are many payment options available for your ease.",
      question: "Are you currently taking any medications?", // Example question
    ),
    // Add more questions as needed...
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    if (_onbordData[0].preText != null)
      Text_controller.text = _onbordData[0].preText!;
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });

    // Reset TextController text when moving to a new page
    if (_onbordData[index].preText != null) {
      Text_controller.text = _onbordData[index].preText!;
    } else {
      Text_controller.clear();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onbordData.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    final currentData = _onbordData[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Render the image for the page
                        Image.asset(
                          (Theme.of(context).brightness == Brightness.dark &&
                                  currentData.imageDarkTheme != null)
                              ? currentData.imageDarkTheme!
                              : currentData.image,
                          fit: BoxFit.cover,
                          height: 300,
                          width: 300,
                        ),
                        const SizedBox(height: 24),
                        // Render the title
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              currentData.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),

                        // Render the description (optional)
                        // if (currentData.description.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 12),
                        //     child: Text(
                        //       currentData.description,
                        //       style: Theme.of(context).textTheme.bodyText2,
                        //     ),
                        //   ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.purple.shade200,
                      size: 36,
                    ),
                    onPressed: () {
                      if (_pageIndex > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                    width: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: Container(
                      height: 60,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200, // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ], // Optional shadow effect for depth
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color:
                              Colors.white, // Text color (white for contrast)
                          fontWeight:
                              FontWeight.w500, // Adjust weight for the font
                          fontSize: 16, // Set the font size
                        ),
                      ),
                    ),
                  ), // Spacer to push the right arrow to the far right
                  const SizedBox(
                    height: 10,
                    width: 40,
                  ),
                  // Right arrow button (for forward navigation)
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.purple.shade200,
                      size: 36,
                    ),
                    onPressed: () {
                      if (_pageIndex < _onbordData.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
                        // If it's the last page, navigate to SignupScreen
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Onbord {
  final String image, title, description;
  final String? imageDarkTheme;
  final String? question;
  final String? preText;
  String? answer; // Store the answer as a String

  Onbord({
    required this.image,
    required this.title,
    this.preText,
    this.description = "",
    this.imageDarkTheme,
    this.question, // Add question
    this.answer, // Store the answer here
  });
}
