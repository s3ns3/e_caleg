import 'dart:developer';
import 'package:e_caleg/logic/upload_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String> imageCropperView(String? path,UploadDocumentLogic logic, BuildContext context) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: path!,
    compressQuality: 100,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Sesuai Foto',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Sesuaikan Foto',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );

  if (croppedFile != null) {
    log("Image cropped");
    logic.pathPhoto = croppedFile.path;
    return croppedFile.path;
  } else {
    log("Do nothing");
    return '';
  }
}
