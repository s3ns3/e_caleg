import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPhoto extends StatelessWidget {
  final String? pathImage;
  final double width;
  const DisplayPhoto({super.key, this.pathImage, this.width = .7});

  @override
  Widget build(BuildContext context) {
    Widget w;
    // with image
    if (pathImage != null) {
      File imageFile = File(pathImage!);
      w = ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(imageFile,
          width: MediaQuery.of(context).size.width*.7,
        ),
      );
    } else {
      w = Image.asset(
            'assets/images/icons/document.png',
            width: MediaQuery.of(context).size.width*width,
          );
    }


    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0)),
        child: w);
  }
}
