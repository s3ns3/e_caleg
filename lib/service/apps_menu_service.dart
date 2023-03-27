import 'package:e_caleg/vo/menu_vo_icon.dart';

class AppsMenuService {
  static const id = 'AppsMenuService';

  static final AppsMenuService _instance = AppsMenuService();

  static AppsMenuService get() => _instance;
  final List<MenuVOIcon> _listMainMenu = [
    MenuVOIcon(
      icon: 'assets/images/icons/home.png',
      label: 'Home',
      showOrder: 0,
    ),
    MenuVOIcon(
      icon: 'assets/images/icons/timses.png',
      label: 'Timses',
      showOrder: 1,
    ),
    MenuVOIcon(
      icon: 'assets/images/icons/saksi.png',
      label: 'Saksi',
      showOrder: 2,
    ),
    MenuVOIcon(
      icon: 'assets/images/icons/peta.png',
      label: 'Peta',
      showOrder: 3,
    ),
    MenuVOIcon(
      icon: 'assets/images/icons/setting.png',
      label: 'Setting',
      showOrder: 4,
    ),
  ];
  void init() {
    // what need to be initialized here?
  }

  List<MenuVOIcon> get listMenu => _listMainMenu;
}
