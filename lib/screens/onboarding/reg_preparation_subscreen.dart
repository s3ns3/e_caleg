import 'dart:convert';
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/logic/login_logic.dart';
import 'package:e_caleg/screens/onboarding/ktp_regis_subscreen.dart';
import 'package:e_caleg/screens/registration_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';

class RegPreparationSubscreen extends BaseRegSubScreen {
  static const id = 'RegPreparationSubscreen';

  final logic = LoginLogic();

  RegPreparationSubscreen({Key? key})
      : super(
            key: key,
            onBack: () {
              NavigationService.get().pop();
            });

  @override
  String getRegInfo() {
    return '';
  }

  @override
  int getPageIndex() {
    return kPagePreparation;
  }

  @override
  Widget buildSubScreen(BuildContext context) {
    return _displayBodyContent(context);
  }

  Widget _displayBodyContent(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            Text('Pastikan kartu identitasmu dalam kondisi baik',
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue)),
            SizedBox(height: 20.0),
            _listPreparation('Menggunakan E-KTP asli bukan hasil scan'),
            _listPreparation('Pastikan foto KTP jelas dan tidak blur'),
            _listPreparation('Pastikan foto tidak terpotong atau tertutup'),
            _listPreparation('Pastikan foto dalam kondisi terang'),
          ],
        )),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10),
            child: AppsGradientButton(
              label: 'AMBIL FOTO',
              boxColor: gradientButton,
              onPressed: () async {
                if(Foundation.kReleaseMode) {
                  try {
                    OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(
                        withFlash: true, cameraOnly: true);
                    debugPrint('result: ${res.toString()}');
                    if (res.isSuccess ?? false) {
                      NavigationService.get().push(KtpRegisSubScreen(res: res));
                    }
                  } catch (e) {
                    debugPrint('something goes wrong $e');
                  }
                }else {
                  // For test
                  final picker = ImagePicker();
                  var filePicked = await picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 2048.0,
                      maxHeight: 2048.0,
                      preferredCameraDevice: CameraDevice.front);
                  OcrResultModel res = OcrResultModel(
                      isSuccess: true,
                      errorMessage: '',
                      imagePath: filePicked?.path ?? '',
                      ktp: new Ktp(
                          nik: '1231243523523523',
                          nama: 'SAMSUL BAHARI',
                          tempatLahir: 'tempatLahir',
                          golDarah: 'golDarah',
                          tglLahir: 'tglLahir',
                          jenisKelamin: 'jenisKelamin',
                          alamat: 'alamat',
                          rt: 'rt',
                          rw: 'rw',
                          kelurahan: 'kelurahan',
                          kecamatan: 'kecamatan',
                          agama: 'agama',
                          statusPerkawinan: 'statusPerkawinan',
                          pekerjaan: 'pekerjaan',
                          kewarganegaraan: 'kewarganegaraan',
                          berlakuHingga: 'berlakuHingga',
                          provinsi: 'provinsi',
                          kabKot: 'kabKot'));
                  NavigationService.get().push(KtpRegisSubScreen(res: res));
                }
              },
            ))
      ],
    ));
  }

  Container _listPreparation(String label) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: Row(
          children: [
            Image.asset('assets/images/icons/ob_checked.png'),
            SizedBox(width: 5.0),
            Text(label, style: TextStyle(fontSize: kFontSizeMedium)),
          ],
        ));
  }
}
