import 'package:ecommarce/features/home/cart/bloc/cart_bloc.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_event.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessDialog extends StatefulWidget {
  const OrderSuccessDialog({super.key});

  @override
  State<OrderSuccessDialog> createState() => _OrderSuccessDialogState();
}

class _OrderSuccessDialogState extends State<OrderSuccessDialog> {
  CartBloc? cartBloc;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cartBloc?.add(ClearCartEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.6, //double.infinity,
      width: MediaQuery.sizeOf(context).width*0.8,//double.infinity,
      color: ColorConstants.white,//const Color(0x0d53b175),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/png/image_success.png', fit: BoxFit.scaleDown, height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.4,),
          Text('Your Order has been accepted', textAlign: TextAlign.center, style: TextStyleTypography.typoSemiBoldStyle20.copyWith(color: const Color(0xff181725), decoration: TextDecoration.none,),),
          const SizedBox(height: 4,),
          Text('Your item has been placed and is on it is way to being processed', textAlign: TextAlign.center, style: TextStyleTypography.typoNormalStyle12.copyWith(color: Colors.grey, decoration: TextDecoration.none,),),
          const SizedBox(height: 20,),
          FilledButton(
            onPressed: () {
              context.pop();
              context.push(AppRouteConstantPath.home);
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
            child: Text('Back to home', style: TextStyleTypography.typoBoldStyle14.copyWith(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
