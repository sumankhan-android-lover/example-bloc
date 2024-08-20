
import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';

sealed class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState{}

/*class AddToCartState extends CartState{
  AddCartDataModel model;

  AddToCartState(this.model);
}*/

class AddToCartState extends CartState{
  Map<String, dynamic> data;

  AddToCartState(this.data);
}

class FetchCartState extends CartState{
  List<CartDataModel> items;

  FetchCartState(this.items);
}

class ClickIncreaseButton extends CartState{
  bool plusButtonDisabled;
  final int itemId;

  ClickIncreaseButton(this.plusButtonDisabled, this.itemId);
}

class ClickDecreaseButton extends CartState{
  bool minusButtonDisabled;
  final int itemId;

  ClickDecreaseButton(this.minusButtonDisabled, this.itemId);
}

class UpdateCartItemCount extends CartState{
  String itemCount;

  UpdateCartItemCount(this.itemCount);
}

class CartErrorState extends CartState{
  final String error;

  CartErrorState(this.error);
}
