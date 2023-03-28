import 'dart:io';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/logic/ktp_logic.dart';
import 'package:e_caleg/screens/onboarding/create_pass_subscreen.dart';
import 'package:e_caleg/screens/registration_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';

class KtpRegisSubScreen extends BaseRegSubScreen {
  static const id = 'RegPreparationSubscreen';

  final OcrResultModel res;
  KtpRegisSubScreen({Key? key, required this.res,})
      : super(
      key: key,
      onBack: () {
        NavigationService.get().pop();
      });


  KtpLogic logic = KtpLogic();
  @override
  String getRegInfo() {
    return '';
  }

  @override
  int getPageIndex() {
    return kPageDataPersonal;
  }

  @override
  Widget buildSubScreen(BuildContext context) {
    if(res.ktp != null) {
      logic.nik.inputValue = res.ktp!.nik ?? '';
      logic.name.inputValue = res.ktp!.nama ?? '';
      logic.birthPlace.inputValue = res.ktp!.tempatLahir ?? '';
      logic.birthDate.inputValue = res.ktp!.tglLahir ?? '';
      logic.address.inputValue = res.ktp!.alamat ?? '';
      logic.province.inputValue = res.ktp!.provinsi ?? '';
      logic.city.inputValue = res.ktp!.kabKot ?? '';
      logic.district.inputValue = res.ktp!.kelurahan ?? '';
      logic.ward.inputValue = res.ktp!.kecamatan ?? '';
      logic.religion.inputValue = res.ktp!.agama ?? '';
      logic.job.inputValue = res.ktp!.pekerjaan ?? '';
      logic.maritalStatus.inputValue = res.ktp!.statusPerkawinan ?? '';
      logic.citizenship.inputValue = res.ktp!.kewarganegaraan ?? '';
      logic.gender.inputValue = res.ktp!.jenisKelamin ?? '';
      String rt = res.ktp!.rt ?? '';
      String rw = res.ktp!.rw ?? '';
      logic.rtrw.inputValue = "$rt / $rw";
    }

    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: _displayBody(context),
      ),
    );
  }

  Widget _displayBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          const Text(
            'Data Registrasi',
            style: TextStyle(
                color: Colors.black87,
                fontSize: fontSizeMedium,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12.0,),
          Image.file(File(res.imagePath!)),
          AppsInput(inputVO: logic.nik),
          AppsInput(inputVO: logic.name),
          AppsInput(inputVO: logic.gender),
          AppsInput(inputVO: logic.birthPlace),
          AppsInput(inputVO: logic.birthDate),
          AppsInput(inputVO: logic.address),
          AppsInput(inputVO: logic.province),
          AppsInput(inputVO: logic.city),
          AppsInput(inputVO: logic.district),
          AppsInput(inputVO: logic.ward),
          AppsInput(inputVO: logic.rtrw),
          AppsInput(inputVO: logic.religion),
          AppsInput(inputVO: logic.job),
          AppsInput(inputVO: logic.maritalStatus),
          AppsInput(inputVO: logic.citizenship),
          AppsInput(inputVO: logic.referalCode),
          const SizedBox(height: 18.0,),
          AppsGradientButton(label: 'DAFTAR', onPressed: () {
            NavigationService.get().push(CreatePassSubScreen());
          },)
        ],
      ),
    );
  }

}