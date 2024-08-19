import 'package:ecommarce/features/home/explore/bloc/category_item_bloc/category_item_bloc.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class ExploreItemListPage extends StatefulWidget {
  final String path;

  const ExploreItemListPage({required this.path, super.key});

  @override
  State<ExploreItemListPage> createState() => _ExploreItemListPageState();
}

class _ExploreItemListPageState extends State<ExploreItemListPage> {
  String title = "Category Item List";
  CategoryItemBloc? categoryItemBloc;
  List<ProductDataModel> productItems = [];

  @override
  void initState() {
    // debugPrint("path - ${widget.path}");
    categoryItemBloc = BlocProvider.of<CategoryItemBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    categoryItemBloc?.add(FetchCategoryItemEvent(widget.path));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryItemBloc, CategoryItemState>(
      builder: (context, state) {
        if (state is CategoryItemLoadingState || state is CategoryItemInitialState) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.primaryColor),
            ),
          );
        }

        if (state is CategoryItemLoadedState) {
          productItems = state.productItems;
        }

        if (state is CategoryItemErrorState) {
          return Center(child: Text(state.error));
        }

        return Scaffold(
          backgroundColor: const Color(0x0d53b175),
          appBar: exploreItemListAppBar(title),
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 2 / 3, // Aspect ratio of each item
              ),
              itemCount: productItems.isNotEmpty ? productItems.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return productItemWidget(productItems[index]);
              },
            ),
          ),
        );
      },
    );
  }

  AppBar exploreItemListAppBar(String title) => AppBar(
        title: Text(
          title,
          style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
        ),
        backgroundColor: AppThemeColor.primaryColor,
      );

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
                    child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Stack(
                        children: [
                          Image.network(
                            '${productItem.image}',
                            fit: BoxFit.fill,
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
                        ],
                      ),
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
