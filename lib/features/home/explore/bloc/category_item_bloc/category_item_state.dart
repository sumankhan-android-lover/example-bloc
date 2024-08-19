part of 'category_item_bloc.dart';

sealed class CategoryItemState {}

class CategoryItemInitialState extends CategoryItemState {}

class CategoryItemLoadingState extends CategoryItemState{}

class CategoryItemLoadedState extends CategoryItemState{
  final List<ProductDataModel> productItems;

  CategoryItemLoadedState(this.productItems);
}

class CategoryItemErrorState extends CategoryItemState{
  final String error;

  CategoryItemErrorState(this.error);
}

