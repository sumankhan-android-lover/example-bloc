part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int? userId;
  final Map<String, dynamic>? products;
  final String? dateTime;

  AddToCartEvent(this.userId, this.products, this.dateTime);
}
