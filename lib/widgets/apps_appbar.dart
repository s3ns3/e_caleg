import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color buttonColor;
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.buttonColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(
          color: buttonColor, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
        ),);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(50.0);
  }
}
