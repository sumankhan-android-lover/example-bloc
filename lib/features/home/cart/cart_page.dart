import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_bloc.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_event.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_state.dart';
import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/common_function.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc? cartBloc;
  List<CartDataModel> cartList = [];

  // double? totalPrice;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cartBloc?.add(FetchCartEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Cart", isAction: true, callback: () {
        cartBloc?.add(ClearCartEvent());
      }),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is FetchCartState) {
              cartList = state.items;
              // totalPrice = cartList.fold(0, (sum, item)=> sum! + (item.count! * item.price!));
            }

            if (state is CartErrorState) {
              return Center(child: Text(state.error));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) => cartItem(cartList[index], index),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        Text('Total Price :', style: TextStyleTypography.typoSemiBoldStyle12.copyWith(color: Colors.grey),),
                        const SizedBox(height: 4,),
                        Text('\u{20B9}${cartBloc?.totalPrice.toStringAsFixed(2)}', style: TextStyleTypography.heading14, textAlign: TextAlign.center,),
                      ],
                    ),
                    const Spacer(),
                    FilledButton(
                    onPressed: cartBloc!.totalPrice > 0.00 ? () {} : null,
                    style: ButtonStyle(
                      backgroundColor: cartBloc!.totalPrice > 0.00 ? WidgetStateProperty.all<Color>(AppThemeColor.primaryColor) : WidgetStateProperty.all<Color>(Colors.grey),
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
                    child: Text( "Buy Now",
                      style: TextStyleTypography.typoBoldStyle14.copyWith(color: Colors.white),
                    ),
                  ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget cartItem(CartDataModel cartData, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 8,
        right: 8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                '${cartData.image}',
                width: 55,
                height: 55,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cartData.title}',
                      style: TextStyleTypography.typoBoldStyle14,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '\u{20B9}${cartData.price}',
                      style: TextStyleTypography.typoMediumStyle12,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    increaseDecreaseWidget(cartData),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // crossAxisAlignment: CrossAxisAlignment.spa,
                children: [
                  InkWell(
                    onTap: () {
                      cartBloc?.add(RemoveCartEvent(cartData.id!));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: CommonSVGIcon(
                        imageName: 'icon_delete',
                        imagePath: 'icon',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '\u{20B9}${(cartData.price! * cartData.count!).toStringAsFixed(2)}',
                    style: TextStyleTypography.typoBoldStyle14,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget increaseDecreaseWidget(CartDataModel cartData) => BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          bool plusButtonDisabled = false;
          bool minusButtonDisabled = false;
          int? itemCount = cartData.count;

          if (state is ClickIncreaseButton && state.itemId == cartData.id) {
            debugPrint("plus button click - ${state.plusButtonDisabled}");
            plusButtonDisabled = state.plusButtonDisabled;
          }

          if (state is ClickDecreaseButton && state.itemId == cartData.id) {
            debugPrint("minus button click - ${state.minusButtonDisabled}");
            minusButtonDisabled = state.minusButtonDisabled;
          }

          if (state is UpdateCartItemCount) {
            debugPrint("update cart count - ${state.itemCount}");
            itemCount = int.parse(state.itemCount);
          }

          return Row(
            children: [
              IconButton(
                onPressed: minusButtonDisabled ? null : () => clickMinusButton(cartData),
                icon: CommonSVGIcon(
                  imageName: 'icon_minus',
                  imagePath: 'icon',
                  width: 16,
                  color: minusButtonDisabled ? const Color(0xFFB3B3B3) : const Color(0xFF53B175),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                height: 24,
                width: 24,
                decoration: BorderConstants.border1x.copyWith(
                  border: Border.all(
                    width: BorderConstants.borderWidth1x,
                    color: ColorConstants.black3,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$itemCount',
                  style: TextStyleTypography.typoMediumStyle14,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              IconButton(
                onPressed: plusButtonDisabled ? null : () => clickPlusButton(cartData),
                icon: CommonSVGIcon(
                  imageName: 'icon_plus',
                  imagePath: 'icon',
                  height: 16,
                  width: 16,
                  color: plusButtonDisabled ? const Color(0xFFB3B3B3) : const Color(0xFF53B175),
                ),
              ),
            ],
          );
        },
      );

  clickPlusButton(CartDataModel cartData) {
    cartData.count = cartData.count == 20 ? 20 : cartData.count! + 1;
    debugPrint("plus data - ${cartData.count}");
    cartBloc?.add(UpdateCartEvent(cartData, "plus"));
  }

  clickMinusButton(CartDataModel cartData) {
    cartData.count = cartData.count == 1 ? 1 : cartData.count! - 1;
    debugPrint("minus data - ${cartData.count}");
    cartBloc?.add(UpdateCartEvent(cartData, "minus"));
  }
}
