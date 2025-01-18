import 'package:fitnessapp/utils/Details_page.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ActivityTimeline extends StatelessWidget {
  double width;
  double height;
  ActivityTimeline({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ActivityTile(timeLabel: '1 day ago', activity: 'Scanned Item 1'),
        ActivityTile(timeLabel: '10 hours ago', activity: 'Scanned Item 2'),
        ActivityTile(timeLabel: '10 minutes ago', activity: 'Scanned Item 3'),
      ],
    );
  }
}

class ActivityTile extends StatelessWidget {
  final String timeLabel;
  final String activity;

  ActivityTile({required this.timeLabel, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0), // Padding between tiles
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryG, // Using the gradient from AppColors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(8), // Optional: rounded corners
        ),
        child: ListTile(
          leading: Icon(
            Icons.access_time,
            color: Colors.white,
          ),
          title: Text(
            activity,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            timeLabel,
            style: TextStyle(color: Colors.white),
          ),
          trailing: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(),
                  ));
            },
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
