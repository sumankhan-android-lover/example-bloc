import 'package:ecommarce/data/local/repository/cart_repository.dart';
import 'package:ecommarce/data/local/repository/favorite_repository.dart';
import 'package:ecommarce/data/network/repository/category_repository.dart';
import 'package:ecommarce/data/network/repository/home_repository.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_bloc.dart';
import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';
import 'package:ecommarce/features/home/explore/bloc/category_bloc/category_bloc.dart';
import 'package:ecommarce/features/home/explore/bloc/category_item_bloc/category_item_bloc.dart';
import 'package:ecommarce/features/home/favourite/bloc/favourite_bloc.dart';
import 'package:ecommarce/features/home/favourite/model/favourite/favorite_model.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_bloc.dart';
import 'package:ecommarce/helpers/globals.dart';
import 'package:ecommarce/navigation/app_route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure Flutter engine is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  // Register the adapters
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(RatingAdapter());
  Hive.registerAdapter(CartDataModelAdapter());
  // Open the Hive box to store FavoriteModel objects
  var favoriteBox = await Hive.openBox<FavoriteModel>(Globals.favoriteBox);
  var cartBox = await Hive.openBox<CartDataModel>(Globals.cartBox);

  ///network
  final HomeRepository homeRepository = HomeRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  ///local
  final FavoriteRepository favoriteRepository = FavoriteRepository(favoriteBox);
  final CartRepository cartRepository = CartRepository(cartBox);

  runApp(MyApp(
    homeRepository: homeRepository,
    categoryRepository: categoryRepository,
    favoriteRepository: favoriteRepository,
    cartRepository: cartRepository,
  ));
}

class MyApp extends StatelessWidget {
  HomeRepository? homeRepository;
  CartRepository? cartRepository;
  CategoryRepository? categoryRepository;
  FavoriteRepository? favoriteRepository;

  MyApp({this.homeRepository, this.cartRepository, this.categoryRepository, this.favoriteRepository, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(homeRepository),
        ),
        BlocProvider(
          create: (context) => CartBloc(cartRepository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(categoryRepository),
        ),
        BlocProvider(
          create: (context) => CategoryItemBloc(categoryRepository),
        ),
        BlocProvider(
          create: (context) => FavouriteBloc(favoriteRepository!),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouteConfig.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
