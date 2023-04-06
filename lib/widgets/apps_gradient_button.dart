import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:flutter/material.dart';

class AppsGradientButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final double fontSize;
  final String label;
  final Gradient boxColor;
  final Color textColor;
  final VoidCallback onPressed;

  AppsGradientButton({
    this.height = 50.0,
    this.radius = 50.0,
    this.fontSize = kFontSizeMedium,
    this.width = double.infinity,
    required this.label,
    this.boxColor = gradientButton,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black38, offset: Offset(0, 6), blurRadius: 2.0)],
            gradient: boxColor, borderRadius: BorderRadius.circular(radius)),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
