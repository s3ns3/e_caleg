import 'package:flutter/material.dart';

const fontSizeSmall = 12.0;
const fontSizeMedium = 16.0;
const fontSizeLarge = 18.0;
const fontSizeHeadline = 36.0;

const paddingSmall = 12.0;
const paddingMedium = 36.0;
const paddingLarge = 72.0;

const marginSmall = 12.0;
const marginMedium = 36.0;

const Color colorPrimary = Color(0xFF2D4BA3);
const Color colorPrimaryLight = Color(0xFF23A9F3);
const Color colorSecondary = Color(0xFFC52026);
const Color colorBackground = Color(0xFFEBEBEB);

const Gradient gradientBackground = LinearGradient(colors: [
  Color(0xFF0057A8),
  Color(0xFF1F8AD3),
  Color(0xFF1F9FEA),
  Color(0xFF1FB2FF),
  Color(0xFF1F9FEA),
  Color(0xFF1F8AD3),
  Color(0xFF0057A8),
]);

const Gradient gradientHeader = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0057A8),
      Color(0xFF1F8AD3),
      Color(0xFF1F9FEA),
      Color(0xFF1FB2FF),
    ]);

const Gradient gradientBtn = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1FB2FF),
      Color.fromRGBO(31, 178, 255, 1),
      Color.fromRGBO(31, 178, 255, .8),
      Color.fromRGBO(31, 178, 255, .6),
      Color.fromRGBO(31, 178, 255, .2),
    ]);
