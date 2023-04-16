import 'package:e_caleg/screens/upload/upload_full_subscreen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70.0,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        gradient: kLinearGradient,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(100.0),
                        )),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.settings_outlined,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.logout,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: kMarginBodyHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(120.0),
                          border: Border.all(color: Colors.white, width: 6.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/images/icons/user.png',
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Asep Setiawan',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kFontSizeXLarge),
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Jl. Garut No.11, Kacapiring, Kec. Batununggal, Kota Bandung, Jawa Barat 40271',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'TPS 001',
                    style: TextStyle(
                        color: kColorBlueDark,
                        fontWeight: FontWeight.w900,
                        fontSize: kFontSizeXLarge),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppsGradientButton(
                          radius: 8.0,
                          label: 'Upload C1 DPRRI',
                          onPressed: () {
                            NavigationService.get().push(UploadFullSubscreen(title: 'Upload C1 DPRRI'));
                          },
                        ),
                        const SizedBox(height: 5.0),
                        AppsGradientButton(
                          radius: 8.0,
                          label: 'Upload C1 DPR Privinsi',
                          onPressed: () {
                            NavigationService.get().push(UploadFullSubscreen(title: 'Upload C1 DPR Privinsi'));
                          },
                        ),
                        const SizedBox(height: 5.0),
                        AppsGradientButton(
                          radius: 8.0,
                          label: 'Upload C1 DPRD',
                          onPressed: () {
                            NavigationService.get().push(UploadFullSubscreen(title: 'Upload C1 DPRD'));
                          },
                        ),
                        const SizedBox(height: 5.0),
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
