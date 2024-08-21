import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatelessWidget {
  final Widget child;

  const BottomNavigationPage({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int idx) => _onItemTapped(idx, context),
        selectedItemColor: AppThemeColor.primaryColor,
        unselectedItemColor: AppThemeColor.deepBlue,
        selectedLabelStyle: TextStyleTypography.typoBoldStyle12.copyWith(color: AppThemeColor.primaryColor, fontSize: 10),
        unselectedLabelStyle: TextStyleTypography.typoBoldStyle12.copyWith(color: AppThemeColor.deepBlue, fontSize: 10),
        items: [
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              imageName: 'tab_icon_shop',
              imagePath: 'icon',
              color: currentIndex == 0 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              imageName: 'tab_icon_explore',
              imagePath: 'icon',
              color: currentIndex == 1 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              imageName: 'tab_icon_cart',
              imagePath: 'icon',
              color: currentIndex == 2 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CommonSVGIcon(
              imageName: 'tab_icon_favourite',
              imagePath: 'icon',
              color: currentIndex == 3 ? AppThemeColor.primaryColor : AppThemeColor.deepBlue,
            ),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == AppRouteConstantPath.home) {
      return 0;
    }
    if (location == AppRouteConstantPath.explore) {
      return 1;
    }
    if (location == AppRouteConstantPath.cart) {
      return 2;
    }
    if (location == AppRouteConstantPath.favourite) {
      return 3;
    }
    return 0; // Default case
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRouteConstantPath.home);
        break;
      case 1:
        GoRouter.of(context).go(AppRouteConstantPath.explore);
        break;
      case 2:
        GoRouter.of(context).go(AppRouteConstantPath.cart);
        break;
      case 3:
        GoRouter.of(context).go(AppRouteConstantPath.favourite);
        break;
    }
  }
}
