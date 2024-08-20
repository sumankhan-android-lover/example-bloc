import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';

sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartDataModel item;

  AddToCartEvent(this.item);
}

class FetchCartEvent extends CartEvent{}

class RemoveCartEvent extends CartEvent {
  final int id;

  RemoveCartEvent(this.id);
}

class UpdateCartEvent extends CartEvent {
  final CartDataModel item;
  final String clickEvent;

  UpdateCartEvent(this.item, this.clickEvent);
}

class ClearCartEvent extends CartEvent{}

/*class AddToCartEvent extends CartEvent {
  final int? userId;
  final Map<String, dynamic>? products;
  final String? dateTime;

  AddToCartEvent(this.userId, this.products, this.dateTime);
}*/
