import 'package:e_caleg/constants/apps_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart'
    show CarouselController, CarouselOptions, CarouselSlider;

class DisplayCarousel extends StatefulWidget {
  @override
  State<DisplayCarousel> createState() => _DisplayCarouselState();
}

class _DisplayCarouselState extends State<DisplayCarousel> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  List<String> imageList = [
    'assets/slider/pan_activity1.png',
    'assets/slider/pan_activity2.png',
    'assets/slider/pan_activity3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 170,
            autoPlay: true,
            reverse: false,
            enableInfiniteScroll: false,
            viewportFraction: 3.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,),
                  child: Image.asset(i),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
