import 'package:hive/hive.dart';

part 'favorite_model.g.dart'; // Generates the adapter

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? image;
  @HiveField(6)
  Rating? rating;

  FavoriteModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

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

@HiveType(typeId: 1) // Give a unique typeId different from FavoriteModel's
class Rating {
  @HiveField(0)
  double? rate;
  @HiveField(1)
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}
