import 'package:flutter/material.dart';

class Kunjungan {
  final String kelurahan, alamat, iconSrc;
  final Color bgColor;

  Kunjungan({
    required this.kelurahan,
    this.alamat = "Jl. Bantar Jati, No. 9 RT/RW 002/04",
    this.iconSrc = "assets/images/icons/ios.svg",
    this.bgColor = const Color(0xFF7553F6),
  });
}

List<Kunjungan> kunjungan = [
  Kunjungan(kelurahan: "Setu, Cipayung"),
  Kunjungan(
    kelurahan: "Bambu Apus, Cipayung",
    iconSrc: "assets/images/icons/code.svg",
    bgColor: const Color(0xFF80A4FF),
  ),
];

// We need it later
List<Kunjungan> recentCourses = [
  Kunjungan(kelurahan: "State Machine"),
  Kunjungan(
    kelurahan: "Animated Menu",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/images/icons/code.svg",
  ),
  Kunjungan(kelurahan: "Flutter with Rive"),
  Kunjungan(
    kelurahan: "Animated Menu",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc: "assets/images/icons/code.svg",
  ),
];
