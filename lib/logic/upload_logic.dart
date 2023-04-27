import 'dart:io';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/UploadDocumentService.dart';
import 'package:e_caleg/service/apps_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/content_input_vo.dart';
import 'package:e_caleg/vo/document_vo.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class UploadDocumentLogic{

  String? pathPhoto;
  // indicate that selfie has been taken
  bool _hasTakenPhoto = false;
  bool get hasTakenPhoto => _hasTakenPhoto;
  List<GeneralSelectionItem> listPartai=[];

  late List<DocumentVO> documentVO;

  Future<ServiceResponseVO> initLogic() async {
    // prepare for list of master data
    // listPartai = AppsService.get()
    //     .findGeneralSelectionFor(kSelectionItemPartai);
    // await Future.delayed(const Duration(seconds: 50), () sync* {
    //
    // });

    ServiceResponseVO responseVO =  await UploadDocumentService.get().requestInit();
    if(responseVO.rc == rcSuccess){
      documentVO = UploadDocumentService.get().documentVO;
    }

    return responseVO;
  }

  void resetData(){
    _hasTakenPhoto = false;
    pathPhoto =null;
  }

  Future<ServiceResponseVO> processTakePhoto() async {
    _hasTakenPhoto = true;
    debugPrint("selfie");
    final picker = ImagePicker();
    var filePicked = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 2048.0,
        maxHeight: 2048.0,
        preferredCameraDevice: CameraDevice.rear);
    if (filePicked == null) {
      pathPhoto = null;
      return ServiceResponseVO(rcPictureNotTaken, 'Belum mengambil foto');
    }
    File file = File(filePicked.path);
    // ServiceResponseVO respVO = await OnboardingService.get().sendOnboardingSelfie(fileSelfie: fileSelfie);
    // if (respVO.rc != rcSuccess) return respVO;

    // pathPhoto = file.path;
    return ServiceResponseVO(rcSuccess, file.path);
  }

  Future<RecognizedText> recognizeTextFromPhoto() async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    InputImage inputImage = InputImage.fromFilePath(pathPhoto!);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    return recognizedText;
  }

  Future<ServiceResponseVO> prosesInit() async {
    return await UploadDocumentService.get().requestInit();
  }
}