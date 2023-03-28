import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';

import '../../models/kunjungan.dart';
import '../../widgets/kunjungan_card.dart';
import '../../widgets/secondary_course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  Image.asset('assets/images/icons/logo_perindo.png',height: 120,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "KUNJUNGAN",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...kunjungan
                            .map((course) => Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: KunjunganCard(course: course),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15.0),
                    child: Text(
                      "DATA",
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
                                  Text('Total saksi saat ini',style: TextStyle(fontSize: fontSizeSmall),),
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
                            textColor: Colors.white,
                            label: '+ Tambah Saksi',
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/icons/total_c1.png',
                                  width: 30, height: 30),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Formulir C1',style: TextStyle(fontSize: fontSizeSmall)),
                                  Row(
                                    children: [
                                      Text(
                                        '0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: kFontSizeXLarge),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text('Form')
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          AppsGradientButton(
                            width: 120,
                            height: 30,
                            textColor: Colors.white,
                            label: 'Cari Formulir',
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Divider(color: Colors.grey),
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
                                  Text('Total TPS dengan saksi',style: TextStyle(fontSize: fontSizeSmall),),
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
                            textColor: Colors.white,
                            label: 'Cari TPS',
                            onPressed: () {},
                          )
                        ],
                      )
                    ]),
                  ),

                  const SizedBox(height: 60),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
