import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommarce/data/local/repository/cart_repository.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_event.dart';
import 'package:ecommarce/features/home/cart/bloc/cart_state.dart';
import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';
import 'package:flutter/material.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository? repository;
  int highestItemCount = 20;
  int lowestItemCount = 1;
  int? itemCount;

  double totalPrice = 0.00;

  CartBloc(this.repository) : super(CartInitialState()) {
    on<AddToCartEvent>(addToCart); //add
    on<FetchCartEvent>(fetchCart); //get
    on<RemoveCartEvent>(removeCart); //remove
    on<UpdateCartEvent>(updateCart); //update
    on<ClearCartEvent>(clearCart); //clear all

  }



  /*FutureOr<void> addToCart(AddToCartEvent event, Emitter<CartState> emit) async{
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
  }*/

  FutureOr<void> addToCart(AddToCartEvent event, Emitter<CartState> emit) async{
    emit(CartInitialState());
    try{
      Map<String, dynamic>? data = await repository?.addItem(event.item);
      debugPrint("Bloc: data - ${json.encode(data)}");
      if(data?["status"] == true){
        emit(AddToCartState(data!));
      }else{
        emit(CartErrorState('data not found'));
      }
    }catch(e){
      emit(CartErrorState('$e'));
      throw Exception("BloC: add to cart - $e");
    }
  }

  FutureOr<void> fetchCart(FetchCartEvent event, Emitter<CartState> emit) {
    try{
      final items = repository?.getCartItems();
      if(items?.isNotEmpty ?? false){
        // debugPrint('data founds: Size - ${items?.length}');
        totalPrice = items!.fold(0, (sum, item)=> sum + (item.count! * item.price!));
        emit(FetchCartState(items));
      }else{
        emit(CartErrorState('data not found'));
      }
    }catch(e){
      debugPrint("BloC: fetch cart - $e");
      emit(CartErrorState('$e'));
      // throw Exception("BloC: fetch cart - $e");
    }
  }

  FutureOr<void> removeCart(RemoveCartEvent event, Emitter<CartState> emit) async{
    try{
      Map<String, dynamic>? data = await repository?.removeItem(event.id);
      if(data?["status"] == true) {
        List<CartDataModel>? items = repository?.getCartItems();
        // debugPrint("cart data after delete - ${items?.length} || ${json.encode(items)}");
        totalPrice = items!.fold(0, (sum, item)=> sum + (item.count! * item.price!));
        emit(FetchCartState(items));
      } else{
        emit(CartErrorState('data not removed'));
      }
    }catch(e){
      debugPrint("BloC: remove cart - $e");
      emit(CartErrorState('$e'));
    }
  }

  FutureOr<void> updateCart(UpdateCartEvent event, Emitter<CartState> emit) async{
    try{
      Map<String, dynamic>? data = await repository?.updateItem(event.item);
      if(data?["status"] == true){
        totalPrice = repository!.getCartItems().fold(0, (previousValue, element) => previousValue+(element.count!*element.price!));
        if (event.clickEvent == "plus") {
          if(highestItemCount == event.item.count){
            // debugPrint("item count plus 1 - ${event.item.count}");
            emit(UpdateCartItemCount('$highestItemCount'));
            emit(ClickIncreaseButton(true, event.item.id!));
          } else {
            // debugPrint("item count plus 2 - ${event.item.count}");
            emit(UpdateCartItemCount('$itemCount'));
            emit(ClickIncreaseButton(false, event.item.id!));
          }
        } else {
          if(lowestItemCount == event.item.count){
            // debugPrint("item count negative 1 - ${event.item.count}");
            emit(UpdateCartItemCount('$lowestItemCount'));
            emit(ClickDecreaseButton(true, event.item.id!));
          } else{
            // debugPrint("item count negative 2 - ${event.item.count}");
            emit(UpdateCartItemCount('$itemCount'));
            emit(ClickDecreaseButton(false, event.item.id!));
          }
        }
      } else{
        debugPrint("BloC: cart not update");
        emit(CartErrorState('cart not update'));
      }
    } catch(e){
      debugPrint("BloC: update cart - $e");
      emit(CartErrorState('$e'));
    }
  }

  FutureOr<void> clearCart(ClearCartEvent event, Emitter<CartState> emit) async{
    try{
      Map<String, dynamic>? data = await repository?.clearCart();
      if(data?["status"] == true){
        totalPrice = 0.00;
        final items = repository?.getCartItems();
        emit(FetchCartState(items!));
      } else{
        debugPrint("BloC: cart not update");
        emit(CartErrorState('cart not clear'));
      }
    }catch(e){
      debugPrint("BloC: clear cart - $e");
      emit(CartErrorState('$e'));
    }
  }
}
