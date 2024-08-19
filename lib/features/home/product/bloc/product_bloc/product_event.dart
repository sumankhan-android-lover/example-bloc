abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {}

class FetchProductDetailsEvent extends ProductEvent {
  int? productId;
  FetchProductDetailsEvent(this.productId);
}

class PlusMinusClickEvent extends ProductEvent {
  String value;
  PlusMinusClickEvent(this.value);
}