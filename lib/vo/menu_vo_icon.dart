import 'package:flutter/cupertino.dart';

class MenuVOIcon {
  final String icon;
  final String label;
  final int menuType;
  final int showOrder;

  MenuVOIcon({
    required this.icon,
    required this.label,
    this.menuType = 0,
    required this.showOrder,
  });
}
