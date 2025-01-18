import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final dynamic
      icon; // Change from String to dynamic to support both String and IconData
  final TextInputType textInputType;
  final bool isObscureText;
  final Widget? rightIcon;

  const RoundTextField({
    Key? key,
    this.textEditingController,
    required this.hintText,
    required this.icon,
    required this.textInputType,
    this.isObscureText = false,
    this.rightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isObscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            prefixIcon: _getPrefixIcon(),
            suffixIcon: rightIcon,
            hintStyle: TextStyle(fontSize: 12, color: AppColors.grayColor)),
      ),
    );
  }

  Widget _getPrefixIcon() {
    if (icon is String && icon.contains('assets')) {
      // If the icon is an asset image path
      return Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        child: Image.asset(
          icon,
          width: 20,
          height: 20,
          fit: BoxFit.contain,
          color: AppColors.grayColor,
        ),
      );
    } else if (icon is IconData) {
      // If the icon is an IconData (Flutter Icon)
      return Icon(
        icon,
        size: 20,
        color: Colors.black26,
      );
    }
    // If no valid icon is passed, return an empty widget (or you can handle this case better)
    return SizedBox.shrink();
  }
}
