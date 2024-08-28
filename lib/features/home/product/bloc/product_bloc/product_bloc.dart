import 'dart:async';

import 'package:ecommarce/data/network/repository/home_repository.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_event.dart';
import 'package:ecommarce/features/home/product/bloc/product_bloc/product_state.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  HomeRepository? repository;
  int totalProductCount = 20;
  int itemCount = 1;
  bool plusButtonDisabled = false;
  bool minusButtonDisabled = false;

  ProductBloc(this.repository) : super(ProductInitialState()) {
    on<FetchProductEvent>(fetchProductList); // get product items
    on<FetchProductDetailsEvent>(fetchProductDetails); // get product details
    on<PlusMinusClickEvent>(plusMinusButtonClick); // Add cart After click '+' & '-' button
  }

  FutureOr<void> fetchProductList(FetchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
    try {
      List<ProductDataModel>? datum = await repository?.fetchProduct();
      // debugPrint("fetchProductList data - $datum");
      if (datum?.isNotEmpty ?? false) {
        // debugPrint("fetchProductList: data isn't empty");
        emit(FetchProductState(datum!));
      } else {
        debugPrint("fetchProductList: data not found");
        emit(ProductErrorState("data not found"));
      }
    } catch (e) {
      debugPrint("fetchProductList exception: $e");
      emit(ProductErrorState(e.toString()));
    }
  }

  FutureOr<void> fetchProductDetails(FetchProductDetailsEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
    // debugPrint("fetchProductDetails");

    // Reset item count and button states when fetching new product details
    itemCount = 1;
    plusButtonDisabled = false;
    minusButtonDisabled = true;

    try {
      ProductDataModel? datum = await repository?.fetchProductDetails(event.productId);
      // debugPrint("fetchProductDetails data - $datum");
      if (datum != null) {
        // debugPrint("fetchProductDetails: data isn't empty");
        emit(FetchProductDetailsState(datum));
      } else {
        debugPrint("fetchProductDetails: data not found");
        emit(ProductErrorState("data not found"));
      }
    } catch (e) {
      debugPrint("fetchProductDetails exception: $e");
      emit(ProductErrorState(e.toString()));
    }
  }

  FutureOr<void> plusMinusButtonClick(PlusMinusClickEvent event, Emitter<ProductState> emit) {
    if (event.value == "plus") {
      if (totalProductCount == itemCount) {
        itemCount = totalProductCount;
        plusButtonDisabled = true;
        minusButtonDisabled = false;
        emit(PlusMinusClickState((itemCount).toString(), plusButtonDisabled, minusButtonDisabled));
      } else {
        itemCount++;
        minusButtonDisabled = false;
        plusButtonDisabled = false;
        emit(PlusMinusClickState(itemCount.toString(), plusButtonDisabled, minusButtonDisabled));
      }
    } else {
      if (itemCount == 1) {
        itemCount = 1;
        minusButtonDisabled = true;
        plusButtonDisabled = false;
        emit(PlusMinusClickState((1).toString(), plusButtonDisabled, minusButtonDisabled));
      } else {
        itemCount--;
        minusButtonDisabled = false;
        plusButtonDisabled = false;
        emit(PlusMinusClickState(itemCount.toString(), plusButtonDisabled, minusButtonDisabled));
      }
    }
  }



}
