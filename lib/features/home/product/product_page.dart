import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/features/home/favourite/bloc/favourite_bloc.dart';
import 'package:ecommarce/features/home/favourite/model/favourite/favorite_model.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_bloc.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_event.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_state.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import 'model/product_data_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductBloc? productBloc;
  FavouriteBloc? favouriteBloc;
  List<ProductDataModel> productItems = [];

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    favouriteBloc = BlocProvider.of<FavouriteBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    productBloc?.add(FetchProductEvent());
    // favouriteBloc?.add(ClearAllFavouritesEvent()); //hive favorite data clear
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0d53b175),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "LuxeLane",
          style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
        ),
        backgroundColor: AppThemeColor.primaryColor,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoadingState || state is ProductInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.primaryColor),
              ),
            );
          }

          if (state is FetchProductState) {
            productItems = state.productItems;
          }

          if (state is ProductErrorState) {
            return Center(child: Text(state.error));
          }

          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                // crossAxisSpacing: 6.0,  // Space between columns
                // mainAxisSpacing: 6.0,  // Space between rows
                childAspectRatio: 2 / 2, // Aspect ratio of each item
              ),
              itemCount: productItems.isNotEmpty ? productItems.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return productItemWidget(productItems[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget productItemWidget(ProductDataModel productItem) => InkWell(
        onTap: () {
          context.pushNamed(AppRouteConstantName.productDetails, extra: productItem);
        },
        child: Card(
          color: const Color(0xFFFFFFFF),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height*0.2,
                          width:  MediaQuery.sizeOf(context).height*0.7,
                          child: Image.network(
                            '${productItem.image}',
                            // fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Text('Failed');
                            },
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: InkWell(
                            onTap: () {
                              final newItem = FavoriteModel(
                                id: productItem.id,
                                title: productItem.title,
                                price: productItem.price,
                                description: productItem.description,
                                category: productItem.category,
                                image: productItem.image,
                              );
                              favouriteBloc?.add(AddRemoveFavouriteEvent(newItem));
                            },
                            child: BlocBuilder<FavouriteBloc, FavouriteState>(
                              builder: (context, state) {
                                //bool isFavorite = false;
                                String imageName;

                                //if (state is LoadedFavouriteState) {
                                //isFavorite = state.items.any((item) => item.id == productItem.id);
                                //debugPrint("Favorite status for ${productItem.title}: $isFavorite");
                                //}
                                //String imageName = isFavorite ? 'icon_favorite_fillable' : 'icon_favorite_non_fillable';

                                  if (state is LoadedFavouriteState && state.items.any((fav) => fav.id == productItem.id)) {
                                    imageName = 'icon_favorite_fillable';
                                  }else{
                                    imageName = 'icon_favorite_non_fillable';
                                  }

                                return CommonSVGIcon(
                                  height: 24,
                                  width: 24,
                                  imageName: imageName,
                                  imagePath: 'icon',
                                  color: AppThemeColor.primaryColor,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Text(
                          "${productItem.title}",
                          textAlign: TextAlign.start,
                          style: TextStyleTypography.typoNormalStyle12,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 30,
                        child: Text(
                          "\u{20B9}${productItem.price}",
                          textAlign: TextAlign.end,
                          style: TextStyleTypography.typoBoldStyle12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  RatingBarIndicator(
                    rating: double.parse('${productItem.rating?.rate ?? 0}'),
                    itemCount: 5,
                    itemSize: 16.0,
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color(0xFFF3603F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
