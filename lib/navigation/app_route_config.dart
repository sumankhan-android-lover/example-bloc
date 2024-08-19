import 'package:ecommarce/features/home/explore/explore_page.dart';
import 'package:ecommarce/features/home/favourite/favourite_page.dart';
import 'package:ecommarce/features/home/cart/cart_page.dart';
import 'package:ecommarce/features/home/explore/explore_item_list_page.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:ecommarce/features/home/product/product_details_page.dart';
import 'package:ecommarce/features/home/product/product_page.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:ecommarce/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouteConfig {
  static final AppRouteConfig _instance = AppRouteConfig._internal();

  static AppRouteConfig get instance => _instance;

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(); // Make it static

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteConstantPath.home,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey, // Now this works because _shellNavigatorKey is static
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BottomNavigationPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteConstantPath.home,
            name: AppRouteConstantName.home,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductPage();
            },
          ),
          GoRoute(
            path: AppRouteConstantPath.explore,
            name: AppRouteConstantName.explore,
            builder: (BuildContext context, GoRouterState state) {
              return const ExplorePage();
            },
            // routes: <RouteBase> [
            //   GoRoute(
            //     parentNavigatorKey: _rootNavigatorKey,
            //     name: AppRouteConstantName.exploreItemList,
            //     path: AppRouteConstantPath.exploreItemList,
            //     builder: (context, state) {
            //       String data = state.extra as String;
            //       return ExploreItemListPage(path: data,);
            //     },
            //   ),
            // ]
          ),

          GoRoute(
            name: AppRouteConstantName.exploreItemList,
            path: AppRouteConstantPath.exploreItemList,
            builder: (context, state) {
              String data = state.extra as String;
              return ExploreItemListPage(path: data,);
            },
          ),

          GoRoute(
            path: AppRouteConstantPath.cart,
            name: AppRouteConstantName.cart,
            builder: (BuildContext context, GoRouterState state) {
              return const CartPage();
            },
          ),

          GoRoute(
            path: AppRouteConstantPath.favourite,
            name: AppRouteConstantName.favourite,
            builder: (BuildContext context, GoRouterState state) {
              return const FavouritePage();
            },
          ),

          GoRoute(
            path: AppRouteConstantPath.productDetails,
            name: AppRouteConstantName.productDetails,
            builder: (BuildContext context, GoRouterState state) {
              ProductDataModel model = state.extra as ProductDataModel;
              return ProductDetailsPage(dataModel: model,);
            },
          ),

        ],
      ),
    ],
  );

  BuildContext get context => router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;
  GoRouteInformationParser get routeInformationParser => router.routeInformationParser;

  factory AppRouteConfig() {
    return _instance;
  }

  AppRouteConfig._internal();
}
