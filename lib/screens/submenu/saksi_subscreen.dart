import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/screens/submenu/saksi/detail_saksi_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';

import '../../models/kunjungan.dart';
import '../../widgets/kunjungan_card.dart';
import '../../widgets/secondary_course_card.dart';

class SaksiScreen extends StatelessWidget {
  const SaksiScreen({super.key});

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
                      "SAKSI",
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
                              Image.asset('assets/images/icons/total_tps.png',
                                  width: 30, height: 30),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total TPS dengan saksi',
                                    style: TextStyle(fontSize: fontSizeSmall),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '39.659',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: kFontSizeXLarge),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text('TPS')
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
                            label: 'Tambah Saksi',
                            onPressed: () {},
                          )
                        ],
                      )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15.0),
                    child: const Text(
                      "Data Saksi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeMedium,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child:
                        Image.asset('assets/images/background/fitur_cari.png'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  cardTps(context, 'Syamsul Bahasri', 'TPS 01', '50', '1.214'),
                  cardTps(context, 'Jennifer Basuki', 'TPS 02', '123', '4.435'),
                  cardTps(context, 'Desi Ratnasari', 'TPS 03', '222', '3.234'),
                  cardTps(context, 'Arturo Soso', 'TPS 04', '124', '3.568'),
                  cardTps(context, 'Jojon Jojon', 'TPS 05', '444', '1.658'),
                  cardTps(
                      context, 'Bunga Cinta Lestari', 'TPS 06', '643', '1.243'),
                  cardTps(context, 'Jajang Sumidah', 'TPS 07', '324', '1.575'),
                  cardTps(
                      context, 'Madrun Bin Beben', 'TPS 08', '325', '1.474'),
                  cardTps(
                      context, 'Jessica Supratman', 'TPS 09', '555', '1.124'),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container cardTps(BuildContext context, String nama, String tps, String suara,
      String totalSuara) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .07,
            child: Text(tps, style: TextStyle(fontSize: kFontSizeSmall)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .2,
            child: Text(nama, style: TextStyle(fontSize: kFontSizeSmall)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Perolehan', style: TextStyle(fontSize: kFontSizeSmall)),
                Row(
                  children: [
                    Text(suara,
                        style: TextStyle(
                            fontSize: kFontSizeSmall,
                            fontWeight: FontWeight.w700)),
                    Text(' dari $totalSuara suara',
                        style: TextStyle(fontSize: kFontSizeSmall)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * .15,
            child: Column(
              children: [
                AppsGradientButton(
                  label: 'Lihat',
                  fontSize: kFontSizeSmall,
                  // width: 100,
                  height: 20,
                  onPressed: () {
                    NavigationService.get().push(DetailSaksiScreen());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
