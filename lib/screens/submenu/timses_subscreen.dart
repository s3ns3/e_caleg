import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';

import '../../models/kunjungan.dart';
import '../../widgets/kunjungan_card.dart';
import '../../widgets/secondary_course_card.dart';

class TimsesScreen extends StatelessWidget {
  const TimsesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background/background_primary.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/icons/logo_perindo.png',
                    height: 120,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15.0),
                    child: Text(
                      "TIM SUKSES",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/icons/total_saksi.png',
                                  width: 30, height: 30),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total timses saat ini',
                                    style: TextStyle(fontSize: fontSizeSmall),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '40.123',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: kFontSizeXLarge),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text('Orang')
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          AppsGradientButton(
                            width: 120,
                            height: 30,
                            fontSize: kFontSizeSmall,
                            textColor: Colors.white,
                            label: '+ Tambah Timses',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15.0),
                    child: const Text(
                      "List aktivitas",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeMedium,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  cardAktivitas(
                      context, 'Budi', 'Menyiapkan tempat kampanye', '23/02/2023'),
                  cardAktivitas(
                      context, 'Budi', 'Survei tampat kampanye', '22/02/2023'),
                  cardAktivitas(
                      context, 'Joko', 'Kunjungan rumah warga', '22/02/2023'),
                  cardAktivitas(
                      context, 'Joko', 'Kunjungan mencari relawan', '21/02/2023'),
                  cardAktivitas(
                      context, 'Budi', 'Survei tampat kampanye', '20/02/2023'),
                  cardAktivitas(
                      context, 'Samsul', 'Pemasangan atribut kampanye', '19/02/2023'),
                  cardAktivitas(
                      context, 'Samsul', 'Pembagian koas kampanye', '18/02/2023'),
                  cardAktivitas(
                      context, 'Samsul', 'Pembagian kalender kampanye', '17/02/2023'),
                  cardAktivitas(
                      context, 'Joko', 'Pembagian bantuan warga', '17/02/2023'),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container cardAktivitas(
      BuildContext context, String nama, String activitas, String tanggal) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 3.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .15,
            child: Text(nama, style: TextStyle(fontSize: kFontSizeMedium)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Aktivitas', style: TextStyle(fontSize: kFontSizeSmall)),
                Text(activitas, style: TextStyle(fontSize: kFontSizeSmall)),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * .2,
            child: Column(
              children: [
                Text(tanggal, style: TextStyle(fontSize: kFontSizeSmall)),
                AppsGradientButton(
                  label: 'Lihat',
                  fontSize: kFontSizeSmall,
                  height: 20,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
