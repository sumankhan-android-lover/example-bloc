import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommarce/data/network/cart_repository.dart';
import 'package:ecommarce/features/home/cart/model/add_cart_data_model.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository? repository;

  CartBloc(this.repository) : super(CartInitialState()) {
    on<AddToCartEvent>(addToCart);
  }

  FutureOr<void> addToCart(AddToCartEvent event, Emitter<CartState> emit) async{
    emit(CartInitialState());
    debugPrint("addToCart in bloc");

    try {
      AddCartDataModel? dataModel = await repository?.addToCart(event.userId, event.dateTime.toString(), event.products as Map<String, dynamic>);
      debugPrint("addToCart data - $dataModel");
      if (dataModel != null) {
        // debugPrint("addToCart: data doesn't empty");
        emit(AddToCartState(dataModel));
      } else {
        debugPrint("addToCart: data not found");
        emit(CartErrorState("data not found"));
      }
    } catch (e) {
      debugPrint("AddToCart exception: $e");
      emit(CartErrorState(e.toString()));
    }
  }
}
