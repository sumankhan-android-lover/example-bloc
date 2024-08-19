/// id : 1
/// title : "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"
/// price : 109.95
/// description : "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday"
/// category : "men's clothing"
/// image : "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
/// rating : {"rate":3.9,"count":120}

import 'dart:convert';

List<ProductDataModel> productDataModelFromJson(String str) => List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromJson(x)));

String productDataModelToJson(List<ProductDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductDataModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating?.toJson(),
  };
}

// enum Category {
//   ELECTRONICS,
//   JEWELERY,
//   MEN_S_CLOTHING,
//   WOMEN_S_CLOTHING
// }
//
// final categoryValues = EnumValues({
//   "electronics": Category.ELECTRONICS,
//   "jewelery": Category.JEWELERY,
//   "men's clothing": Category.MEN_S_CLOTHING,
//   "women's clothing": Category.WOMEN_S_CLOTHING
// });

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}



/*
class ProductDataModel {
  ProductDataModel({
      num? id, 
      String? title, 
      num? price, 
      String? description, 
      String? category, 
      String? image,
      bool isFavorite,
      Rating? rating,}){
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
    _rating = rating;
    _is_favorite = isFavorite;
}

  ProductDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  num? _id;
  String? _title;
  num? _price;
  String? _description;
  String? _category;
  String? _image;
  Rating? _rating;
  bool _isFavorite;

ProductDataModel copyWith({  num? id,
  String? title,
  num? price,
  String? description,
  String? category,
  String? image,
  Rating? rating,
}) => ProductDataModel(  id: id ?? _id,
  title: title ?? _title,
  price: price ?? _price,
  description: description ?? _description,
  category: category ?? _category,
  image: image ?? _image,
  rating: rating ?? _rating,
);
  num? get id => _id;
  String? get title => _title;
  num? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;
  Rating? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;
    map['category'] = _category;
    map['image'] = _image;
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    return map;
  }

}

/// rate : 3.9
/// count : 120

class Rating {
  Rating({
      num? rate, 
      num? count,}){
    _rate = rate;
    _count = count;
}

  Rating.fromJson(dynamic json) {
    _rate = json['rate'];
    _count = json['count'];
  }
  num? _rate;
  num? _count;
Rating copyWith({  num? rate,
  num? count,
}) => Rating(  rate: rate ?? _rate,
  count: count ?? _count,
);
  num? get rate => _rate;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = _rate;
    map['count'] = _count;
    return map;
  }

}*/
