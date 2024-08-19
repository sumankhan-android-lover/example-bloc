/// id : 11
/// userId : 1
/// date : "2020-02-03"
/// products : [{"productId":5,"quantity":2}]

class AddCartDataModel {
  AddCartDataModel({
      num? id, 
      num? userId, 
      String? date, 
      List<Products>? products,}){
    _id = id;
    _userId = userId;
    _date = date;
    _products = products;
}

  AddCartDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _date = json['date'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  num? _id;
  num? _userId;
  String? _date;
  List<Products>? _products;
AddCartDataModel copyWith({  num? id,
  num? userId,
  String? date,
  List<Products>? products,
}) => AddCartDataModel(  id: id ?? _id,
  userId: userId ?? _userId,
  date: date ?? _date,
  products: products ?? _products,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get date => _date;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['date'] = _date;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// productId : 5
/// quantity : 2

class Products {
  Products({
      num? productId, 
      num? quantity,}){
    _productId = productId;
    _quantity = quantity;
}

  Products.fromJson(dynamic json) {
    _productId = json['productId'];
    _quantity = json['quantity'];
  }
  num? _productId;
  num? _quantity;
Products copyWith({  num? productId,
  num? quantity,
}) => Products(  productId: productId ?? _productId,
  quantity: quantity ?? _quantity,
);
  num? get productId => _productId;
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['quantity'] = _quantity;
    return map;
  }

}