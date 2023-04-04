import 'dart:math';

import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/models/menu_btn.dart';
import 'package:e_caleg/models/rive_asset.dart';
import 'package:e_caleg/screens/submenu/dummy_screen.dart';
import 'package:e_caleg/screens/submenu/home_screen.dart';
import 'package:e_caleg/screens/submenu/peta_subscreen.dart';
import 'package:e_caleg/screens/submenu/saksi_subscreen.dart';
import 'package:e_caleg/screens/submenu/timses_subscreen.dart';
import 'package:e_caleg/service/apps_menu_service.dart';
import 'package:e_caleg/utils/constants.dart';
import 'package:e_caleg/utils/rive_utils.dart';
import 'package:e_caleg/vo/menu_vo_icon.dart';
import 'package:e_caleg/widgets/animated_bar.dart';
import 'package:e_caleg/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottomNavs.first;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  // Let's chnage the name
  late SMIBool isSideBarClosed;

  bool isSideMenuClosed = true;

  final PageController _pageController = PageController();
  int _index = 0;
  late RefreshScreenCubit refresh;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      setState(() {});
    });

    refresh = RefreshScreenCubit();
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          // It's time to add the SideMenu
          children: [
            // It shows nothing
            // because now it's under the HomeScreen
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: const SideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: _displayBody(),
                  ),
                ),
              ),
            ),
            // As you can see it's an ANimated button
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 16,
              child: MenuBtn(
                riveOnInit: (artboard) {
                  StateMachineController controller =
                  RiveUtils.getRiveController(artboard,
                      stateMachineName: "State Machine");
                  isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                  // Now it's easy to understand
                  isSideBarClosed.value = true;
                },
                // Let's fixed the scal animation
                press: () {
                  isSideBarClosed.value = !isSideBarClosed.value;
                  if (isSideMenuClosed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = isSideBarClosed.value;
                  });
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Transform.translate(
            offset: Offset(0, 100 * animation.value),
            child: _displayBottomNav(context)));
  }

  Widget _displayBody() {
    return BlocProvider<RefreshScreenCubit>(
        create: (context) => refresh,
        child: BlocBuilder<RefreshScreenCubit, bool>(builder: (context, state) {
          return PageView(
            controller: _pageController,
            children: [
              HomeScreen(),
              TimsesScreen(),
              SaksiScreen(),
              PetaScreen(),
              DummyScreen(),
            ],
            onPageChanged: (idx) {
              setState(() {
                _index = idx;
              });
            },
          );
        }));
  }

  Widget _displayBottomNav(BuildContext context) {
    List<MenuVOIcon> _listMenu = AppsMenuService.get().listMenu;
    return BottomNavigationBar(
        backgroundColor: const Color(0xFF99C7E8),
        // elevation: 0,
        currentIndex: _index,
        onTap: (int idx) {
          debugPrint("index: $idx");
          _index = idx;
          _pageController.animateToPage(idx,
              duration: Duration(milliseconds: 10), curve: Curves.ease);
        },
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedFontSize: 0,
        unselectedLabelStyle: TextStyle(
            color: Colors.grey[600], fontWeight: FontWeight.w700, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: _listMenu.map((menuVO) {
          return BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(
                menuVO.icon,
                color: Colors.grey,
                width: 25,
                height: 25,
              ),
              activeIcon: Image.asset(
                menuVO.icon,
                color: Colors.black,
                width: 25,
                height: 25,
              ),
              label: menuVO.label);
        }).toList());
  }
}
