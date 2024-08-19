part of 'cart_bloc.dart';

sealed class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState{}

class AddToCartState extends CartState{
  AddCartDataModel model;

  AddToCartState(this.model);
}

class CartErrorState extends CartState{
  final String error;

  CartErrorState(this.error);
}
