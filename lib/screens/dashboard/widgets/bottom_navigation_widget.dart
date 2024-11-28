import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class BottomNavigationWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavigationWidget({super.key, required this.navigationShell});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Image.asset(
        Assets.homeIcon,
        height: 20,
        color: Colors.grey,
      ),
      label: homeKey,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Assets.analyticsIcon,
        height: 20,
        color: Colors.grey,
      ),
      label: analyticsKey,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Assets.notificationIcon,
        height: 20,
        color: Colors.grey,
      ),
      label: notificationKey,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Assets.historyIcon,
        height: 20,
        color: Colors.grey,
      ),
      label: historyKey,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Assets.profileIcon,
        height: 20,
        color: Colors.grey,
      ),
      label: profileKey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color selectedIconColor = isDarkMode
        ? Colors.black
        : primaryColor; // Black for selected in dark mode, primaryColor in light mode
    Color unselectedIconColor = isDarkMode
        ? Colors.white
        : Colors.grey; // White for unselected in dark mode, grey in light mode

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (valu, result) {
        log('popscope invoked');
      },
      child: Scaffold(
          body: widget.navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: navItems.map((item) {
              int index = navItems.indexOf(item);
              bool isSelected = index == currentIndex;
              return BottomNavigationBarItem(
                icon: Image.asset(
                  isSelected
                      ? _getSelectedIconPath(index)
                      : _getUnselectedIconPath(index),
                  height: 20,
                  color: isSelected ? selectedIconColor : unselectedIconColor,
                ),
                label: Utils.getTranslatedLabel(context, item.label.toString()),
              );
            }).toList(),
            selectedFontSize: 10,
            unselectedFontSize: 10,
            onTap: _onTap,
            currentIndex: widget.navigationShell.currentIndex,
          )),
    );
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );

    setState(() {
      currentIndex = index;
    });
  }

  String _getSelectedIconPath(int index) {
    switch (index) {
      case 0:
        return Assets.homeIcon;
      case 1:
        return Assets.analyticsIcon;
      case 2:
        return Assets.notificationIcon;
      case 3:
        return Assets.historyIcon;
      case 4:
        return Assets.profileIcon;
      default:
        return '';
    }
  }

  String _getUnselectedIconPath(int index) {
    switch (index) {
      case 0:
        return Assets.homeIcon;
      case 1:
        return Assets.analyticsIcon;
      case 2:
        return Assets.notificationIcon;
      case 3:
        return Assets.historyIcon;
      case 4:
        return Assets.profileIcon;
      default:
        return '';
    }
  }
}
