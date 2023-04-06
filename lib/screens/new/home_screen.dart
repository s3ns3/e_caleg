import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:flutter/material.dart';

import '../../constants/apps_theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _displayBody(context),
      ),
    );
  }

  Widget _displayBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 60.0,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(60.0)),
                      gradient: gradientHeader,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: colorPrimaryLight,)),
                  IconButton(onPressed: () {
                    NavigationService.get().pop();
                  }, icon: const Icon(Icons.login_outlined, color: colorPrimaryLight,)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: marginMedium, top: marginSmall),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 48.0,
                child: Icon(
                  Icons.account_circle,
                  size: 96.0,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: marginMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text("Boedi Setiawan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeLarge),),
              const SizedBox(height: marginSmall,),
              const Text("Jl. Garut No.11, Kacapiring, Kec. Batununggal, Kota Bandung, Jawa Barat 40271", style: TextStyle(fontSize: fontSizeMedium),),
              const SizedBox(height: marginSmall,),
              const Text("TPS Nomor 3", style: TextStyle(color: colorPrimaryLight, fontWeight: FontWeight.bold, fontSize: fontSizeMedium),),
              const SizedBox(height: marginSmall,),
              AppsButton(label: "Upload Foto C1",
                buttonColor: colorPrimaryLight,
                fontSize: fontSizeMedium,
                textColor: Colors.white,
                width: double.infinity,
                onPressed: () {},),
            ],
          ),
        ),
      ],
    );
  }

}