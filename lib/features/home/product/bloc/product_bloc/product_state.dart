import 'package:ecommarce/features/home/product/model/product_data_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class FetchProductState extends ProductState{
  final List<ProductDataModel> productItems;

  FetchProductState(this.productItems);
}

class FetchProductDetailsState extends ProductState{
  final ProductDataModel productDetails;

  FetchProductDetailsState(this.productDetails);
}

class PlusMinusClickState extends ProductState {
  String productCount;
  bool plusButtonDisabled, minusButtonDisabled;

  PlusMinusClickState(this.productCount, this.plusButtonDisabled, this.minusButtonDisabled);
}

class ProductErrorState extends ProductState{
  final String error;

  ProductErrorState(this.error);
}