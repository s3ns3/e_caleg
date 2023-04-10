import 'package:flutter/material.dart';

// size
const kFontSizeXSmall = 10.0;
const kFontSizeSmall = 12.0;
const kFontSizeMedium = 14.0;
const kFontSizeLarge = 16.0;
const kFontSizeXLarge = 18.0;
const kFontSizeHeader = 24.0;
const kFontSizeLargeHeader = 28.0;

const kMarginLeftRight = 10.0;
const kMarginTopBottom = 10.0;
const kMarginTop = 10.0;
const kMarginBottom = 10.0;

const kMarginTopBody = 30.0;
const kMarginBodyHorizontal = 20.0;
const kRoundedCornerSize = 15.0;

const kBlurRadius = 36.0;
const kOffset = 6.0;

const Gradient gradientButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kColorBlueDark, kColorBlueLight, kColorBlueWhite],
    tileMode: TileMode.clamp);

// color
const kColorPrimary = Color(0xFFe0dbc5);
const kColorPrimaryDark = Color(0xFF252525);
const kColorPrimaryLight = Color(0xFF717171);

//TODO: do we need these secondary color?
const kColorSecondary = Color(0xFFFDFDFD);
const kColorSecondaryDark = Color(0xFFFFFFFF);
const kColorSecondaryLight = Color(0xFFFFFFFF);

const kColorBlue = Color(0xFF1B76BB);
const kTextGold = Color(0xFFAD7A27);
const kTextGreen = Color(0xFF24AEA0);

const kColorBlueDark = Color(0xFF1B76BB);
const kColorBlueLight = Color(0xFF0A9DDF);
const kColorBlueWhite = Color(0xFF00ADEE);

const kColorBgOldBlue = Color(0xFF157fb3);
const kColorButtonGold = Color(0xFFECC762);
const kColorButtonRed = Color(0xFFef5350);
const kColorButtonGreen = Color(0xFF1B5E20);

const kColorBgGrey = Color(0xFFF5F5F5);
const kColorFontGrey = Colors.black54;
const kColorBgBlue = Color(0xFFC2E9F8);

const Gradient kButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      kColorButtonRed,
      kColorButtonRed,
      kColorButtonRed,
      kColorButtonRed
    ],
    tileMode: TileMode.clamp);
const Gradient kLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0057A8),
      Color(0xFF1F8AD3),
      Color(0xFF1F9FEA),
      Color(0xFF1FB2FF)
    ]);

const kColorError = Colors.red;

const kColorLine = Color(0XFFF4E9DE);
const kColorLineGrey = Color(0XFFE1E1E1);

// formatting
const kFormatDateDisplay =
    'yyyy-MM-dd'; // this is just for display, NOT for parsing
const kFormatDateDisplaySplash = 'dd/MM/yyyy';
const kFormatDateTimeTrxDisplay = 'dd MMM yyyy, HH:mm';
const kFormatMoneyDisplay = '#,##0';
//table setting
const TABLE_SETTING = 's';
const SETTING_ID = 'i';
const SETTING_DATA = 'd';

const ID_ENC_KEY = 1;
const ID_LANG = 2;
const ID_API_KEY = 3; //enc

const kPaymentMethodCryptshark = 1;
const kPaymentMethodCard = 2;
const kPaymentMethodSepa = 3;

const kPackageTypeCourse = 0;
const kPackageTypeMembership = 1;
