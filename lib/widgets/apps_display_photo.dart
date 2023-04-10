import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPhoto extends StatelessWidget {
  final String? pathImage;

  const DisplayPhoto({super.key, this.pathImage});

  @override
  Widget build(BuildContext context) {
    Widget w;
    // with image
    if (pathImage != null) {
      File imageFile = File(pathImage!);
      w = ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(imageFile,
          width: MediaQuery.of(context).size.width,
        ),
      );
    } else {
      w = Image.asset(
            'assets/images/icons/document.png',
            width: MediaQuery.of(context).size.width,
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
