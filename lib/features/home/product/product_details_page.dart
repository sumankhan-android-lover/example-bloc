import 'dart:convert';
import 'dart:math';

import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/features/common_widget/readmoreText.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_bloc.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_event.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_state.dart';
import 'package:ecommarce/features/home/cart/model/add_cart_data_model.dart';
import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_bloc.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_event.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_state.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/common_function.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDataModel dataModel;

  ProductDetailsPage({required this.dataModel, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductBloc? productBloc;
  CartBloc? cartBloc;

  String productCount = "1";
  ProductDataModel? productDetails;
  // AddCartDataModel? addCartDataModel;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productBloc?.add(FetchProductDetailsEvent(widget.dataModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0d53b175),
      appBar: commonAppBar(widget.dataModel.title!),
      body: productDetailsWidget(),
    );
  }

/*  AppBar detailsAppBar(String title) => AppBar(
        title: Text(
          title, style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
        ),
        backgroundColor: AppThemeColor.primaryColor,
      );*/

  Widget productDetailsWidget() => BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoadingState || state is ProductInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.primaryColor),
              ),
            );
          }

          if (state is FetchProductDetailsState) {
            productDetails = state.productDetails;
            // debugPrint("product details - ${jsonEncode(productDetails)}");
          }

          if (state is ProductErrorState) {
            return Center(child: Text(state.error));
          }

          return Column(
            children: [
              Expanded(
                flex: 30,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: const EdgeInsets.only(top: 8, bottom: 24),
                  child: Image.network(
                    '${productDetails?.image}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 60,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '${productDetails?.title}',
                                style: TextStyleTypography.typoSemiBoldStyle14,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                '\u{20B9}${productDetails?.price}',
                                style: TextStyleTypography.heading18,
                                textAlign: TextAlign.end,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: double.parse('${productDetails?.rating?.rate ?? 0}'),
                              itemCount: 5,
                              itemSize: 16.0,
                              direction: Axis.horizontal,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color(0xFFF3603F),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              " (${productDetails?.rating?.count})",
                              style: TextStyleTypography.typoMediumStyle12,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        ReadMoreText(
                          "${productDetails?.description} Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
                          textAlign: TextAlign.start,
                          style: TextStyleTypography.typoMediumStyle14,
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        const Divider(),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      plusMinusWidget(),
                      const Spacer(),
                      FilledButton(
                          onPressed: () {
                            // Map<String, dynamic> data = {"productId": 5, "quantity": 2};
                            // cartBloc?.add(AddToCartEvent(1, data, "2020-02-03"));
                            final addItem = CartDataModel(
                              count: int.parse(productCount),
                              image: productDetails?.image,
                              description: productDetails?.description,
                              category: productDetails?.category,
                              id: productDetails?.id,
                              price: productDetails?.price,
                              title: productDetails?.title,
                            );
                            cartBloc?.add(AddToCartEvent(addItem));
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(AppThemeColor.primaryColor),
                            // Button background color
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              ),
                            ),
                            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.only(top: 20, bottom: 20, right: 24, left: 24), // Padding inside the button
                            ),
                            shadowColor: WidgetStateProperty.all<Color>(Colors.grey),
                            // Shadow color
                            elevation: WidgetStateProperty.all<double>(4.0),
                          ),
                          child: buttonTextWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );

  Widget plusMinusWidget() => BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          bool plusButtonDisabled = false;
          bool minusButtonDisabled = false;

          if (state is PlusMinusClickState) {
            plusButtonDisabled = state.plusButtonDisabled;
            minusButtonDisabled = state.minusButtonDisabled;
            productCount = state.productCount;
          } else if (state is ProductErrorState) {
            return Center(child: Text(state.error));
          }

          return Row(
            children: [
              IconButton(
                onPressed: minusButtonDisabled ? null : () => clickPlusMinusButton("minus"),
                icon: CommonSVGIcon(
                  imageName: 'icon_minus',
                  imagePath: 'icon',
                  color: minusButtonDisabled ? const Color(0xFFB3B3B3) : const Color(0xFF53B175),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BorderConstants.border1x.copyWith(
                  border: Border.all(
                    width: BorderConstants.borderWidth1x,
                    color: ColorConstants.black3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  productCount,
                  style: TextStyleTypography.typoMediumStyle18,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              IconButton(
                onPressed: plusButtonDisabled ? null : () => clickPlusMinusButton("plus"),
                icon: CommonSVGIcon(
                  imageName: 'icon_plus',
                  imagePath: 'icon',
                  color: plusButtonDisabled ? const Color(0xFFB3B3B3) : const Color(0xFF53B175),
                ),
              ),
            ],
          );
        },
      );

  clickPlusMinusButton(String event) {
    productBloc?.add(PlusMinusClickEvent(event));
  }

  Widget buttonTextWidget() => BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          Map<String, dynamic> success = {};

          if (state is AddToCartState) {
            // addCartDataModel = state.model;
            success = state.data;
          }

          if (state is CartErrorState) {
            return Center(
              child: Text(state.error),
            );
          }

          return Text(
            success.isNotEmpty && success['status'] == true ? "Go to cart" : "Add to cart",
            style: TextStyleTypography.typoBoldStyle14.copyWith(color: Colors.white),
          );
        },
      );

  @override
  void dispose() {
    super.dispose();
    productCount = "1";
    // cartBloc?.dispatch();
  }
}
