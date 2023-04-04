import 'package:e_caleg/screens/ktp_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/display_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'package:flutter/foundation.dart' as Foundation;

import '../models/kunjungan.dart';

class KunjunganCard extends StatelessWidget {
  const KunjunganCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Kunjungan course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 260,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        course.kelurahan,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 3),
                        child: Text(
                          course.alamat,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: DisplayCarousel(),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(
                                  3,
                                  (index) => Transform.translate(
                                    offset: Offset((-10 * index).toDouble(), 0),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          "assets/avaters/Avatar ${index + 1}.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white70),
                                  )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Warga Terkunjung: 50',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black87)),
                                      SizedBox(height: 3.0),
                                      Row(
                                        children: [
                                          AppsButton(
                                              buttonColor: Colors.blue,
                                              textColor: Colors.white,
                                              label: '+ Warga',
                                              width: 60.0,
                                              fontSize: 10,
                                              onPressed: () async{
                                                if(Foundation.kReleaseMode) {
                                                  try {
                                                    OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(
                                                        withFlash: true, cameraOnly: true);
                                                    debugPrint('result: ${res.toString()}');
                                                    if (res.isSuccess ?? false) {
                                                      NavigationService.get().push(KtpScreen(res: res));
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
                                                  NavigationService.get().push(KtpScreen(res: res));
                                                }
                                              }),
                                          SizedBox(width: 3.0),
                                          AppsButton(
                                            buttonColor: Colors.blue,
                                            textColor: Colors.white,
                                            label: '+ Foto',
                                            width: 60.0,
                                            fontSize: 10,
                                            onPressed: () async{
                                              // For test
                                              final picker = ImagePicker();
                                              var filePicked = await picker.pickImage(
                                                  source: ImageSource.camera,
                                                  maxWidth: 2048.0,
                                                  maxHeight: 2048.0,
                                                  preferredCameraDevice: CameraDevice.front);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ]))
              ],
            ),
          ),
          // SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}
