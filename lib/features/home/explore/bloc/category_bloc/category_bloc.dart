import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommarce/data/network/category_repository.dart';
import 'package:flutter/material.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository? repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<FetchCategoriesEvent>(fetchCategories);
  }

  FutureOr<void> fetchCategories(FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    try{
      List<String>? categories = await repository?.fetchCategories();

      if(categories?.isNotEmpty == true){
        // debugPrint("categories: data isn't empty");
        emit(CategoryLoaded(categories!));
      } else{
        debugPrint("fetchProductList: data not found");
        emit(CategoryError("data not found"));
      }
    }catch(e){
      debugPrint("fetchCategories exception: $e");
      emit(CategoryError(e.toString()));
    }
  }

}
