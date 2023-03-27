import 'package:flutter/material.dart';

class AppsButton extends StatelessWidget {
  final String label;
  final double width;
  final double fontSize;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const AppsButton({
    Key? key,
    required this.label,
    this.width = 100,
    this. textColor = Colors.blue,
    this.buttonColor = Colors.white,
    this.fontSize = 12.0,
    required this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
        decoration: BoxDecoration(
          color: buttonColor,
            boxShadow: const [BoxShadow(color: Colors.grey)],
            borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
