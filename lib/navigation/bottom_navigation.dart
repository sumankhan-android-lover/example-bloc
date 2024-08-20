import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              // width: Globals.tabIconSize,
              // height: Globals.tabIconSize,
              imageName: 'tab_icon_shop',
              imagePath: 'icon',
              color: _calculateSelectedIndex(context) == 0 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              // width: Globals.tabIconSize,
              // height: Globals.tabIconSize,
              imageName: 'tab_icon_explore',
              imagePath: 'icon',
              color: _calculateSelectedIndex(context) == 1 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              // width: Globals.tabIconSize,
              // height: Globals.tabIconSize,
              imageName: 'tab_icon_cart',
              imagePath: 'icon',
              color: _calculateSelectedIndex(context) == 2 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              // width: Globals.tabIconSize,
              // height: Globals.tabIconSize,
              imageName: 'tab_icon_favourite',
              imagePath: 'icon',
              color: _calculateSelectedIndex(context) == 3 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Favourite',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRouteConstantName.home)) {
      return 0;
    }
    if (location.startsWith(AppRouteConstantName.explore)) {
      return 1;
    }
    if (location.startsWith(AppRouteConstantName.cart)) {
      return 2;
    }
    if (location.startsWith(AppRouteConstantName.favourite)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(AppRouteConstantName.home);
      case 1:
        GoRouter.of(context).goNamed(AppRouteConstantName.explore);
      case 2:
        GoRouter.of(context).goNamed(AppRouteConstantName.cart);
      case 3:
        GoRouter.of(context).goNamed(AppRouteConstantName.favourite);
    }
  }
}