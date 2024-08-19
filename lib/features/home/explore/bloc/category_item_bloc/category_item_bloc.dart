import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommarce/data/network/category_repository.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:flutter/material.dart';

part 'category_item_event.dart';
part 'category_item_state.dart';

class CategoryItemBloc extends Bloc<CategoryItemEvent, CategoryItemState> {
  CategoryRepository? repository;

  CategoryItemBloc(this.repository) : super(CategoryItemInitialState()) {
    on<FetchCategoryItemEvent>(fetchCategoryItem);
  }

  FutureOr<void> fetchCategoryItem(FetchCategoryItemEvent event, Emitter<CategoryItemState> emit) async{
    emit(CategoryItemLoadingState());

    try{
      List<ProductDataModel>? datum = await repository?.fetchCategoryItem(event.path);
      // debugPrint("fetchCategoryItem data - $datum");
      if (datum?.isNotEmpty ?? false) {
        // debugPrint("fetchCategoryItem: data doesn't empty");
        emit(CategoryItemLoadedState(datum!));
      } else {
        debugPrint("fetchCategoryItem: data not found");
        emit(CategoryItemErrorState("data not found"));
      }
    }catch(e){
      debugPrint("fetchCategoryItem exception: $e");
      emit(CategoryItemErrorState(e.toString()));
    }
  }

}
