import 'dart:io';

import 'package:e_caleg/logic/ktp_logic.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';

import '../constants/apps_theme.dart';

class KtpScreen extends StatelessWidget {
  final OcrResultModel res;

  KtpScreen({super.key, required this.res});
  KtpLogic logic = KtpLogic();

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.all(24.0),
      height: MediaQuery.of(context).size.height,
      color: colorBackground,
      child: ListView(
        children: <Widget>[
          const Text(
            'KTP Warga',
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
          const SizedBox(height: 18.0,),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                "TAMBAHKAN",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}