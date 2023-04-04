import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailSaksiScreen extends StatelessWidget {
  const DetailSaksiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'SAKSI',
        buttonColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: _displayBody(context),
    );
  }

  Widget _displayBody(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/background_primary.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 60.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SAMSUL BAHRI',
                            style: TextStyle(fontSize: fontSizeLarge),
                          ),
                          Row(
                            children: [
                              Text(
                                'TPS',
                                style: TextStyle(fontSize: fontSizeMedium),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '1244',
                                style: TextStyle(
                                    fontSize: fontSizeMedium,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/icons/maps_point.png',
                                width: 35,
                                height: 35,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Kab. Bandung, Kopo\nTaman Kopo Indah',
                                style: TextStyle(fontSize: kFontSizeLarge),
                              )
                            ],
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/icons/logo_perindo.png',
                        width: 100,
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'DATA TPS',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: kFontSizeLarge),
                    )),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Form C1',
                              style: TextStyle(
                                  fontSize: kFontSizeLarge,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 5.0),
                            Image.asset(
                              'assets/images/background/c1.png',
                              width: 200,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  gradient: gradientButton,
                                  // border: Border.all(
                                  //   color: Colors.blue,
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.save_alt,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    'UNDUH',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: kFontSizeMedium),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              'Pendapatan Suara',
                              style: TextStyle(
                                  fontSize: kFontSizeMedium)
                            ),
                            Row(
                              children: [
                                Text(
                                    '279',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                        fontSize: kFontSizeLarge)
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                    'dari 1.239 Suara',
                                    style: TextStyle(
                                        fontSize: kFontSizeMedium)
                                )
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text(
                                'Saksi',
                                style: TextStyle(
                                    fontSize: kFontSizeMedium)
                            ),
                            Image.asset('assets/images/background/ktp.png',width: 150,)
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          )
        ])));
  }
}
