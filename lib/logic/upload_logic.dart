import 'dart:io';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/apps_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/selection_item.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UploadLogic{

  String? pathPhoto;
  // indicate that selfie has been taken
  bool _hasTakenPhoto = false;
  bool get hasTakenPhoto => _hasTakenPhoto;
  List<GeneralSelectionItem> listPartai=[];
  Future<ServiceResponseVO> initLogic() async {
    // prepare for list of master data
    listPartai = AppsService.get()
        .findGeneralSelectionFor(kSelectionItemPartai);
    await Future.delayed(const Duration(seconds: 50), () sync* {

    });
    return ServiceResponseVO(rcSuccess, '');
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

    pathPhoto = file.path;
    return ServiceResponseVO(rcSuccess, '');
  }
}