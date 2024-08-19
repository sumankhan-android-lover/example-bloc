import 'dart:convert';

import 'package:ecommarce/features/home/favourite/model/favourite/favorite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteRepository {
  final Box<FavoriteModel> favoriteBox;

  FavoriteRepository(this.favoriteBox);

  List<FavoriteModel> getFavourites() {
    try {
      List<FavoriteModel> items = favoriteBox.values.toList();

      // If you want to debug-print the items in JSON format:
      List<Map<String, dynamic>> jsonItems = items.map((item) => item.toJson()).toList();
      debugPrint("FavoriteRepository data - ${json.encode(jsonItems)}");
      //end

      return items;
    } catch (e) {
      throw Exception("get favourites error : $e");
    }
  }

  Future<void> addFavourite(FavoriteModel item) async {
    try {
      if(favoriteBox.containsKey(item.id)){
        await favoriteBox.delete(item.id);
      } else {
        await favoriteBox.put(item.id, item);
      }
    } catch (e) {
      throw Exception("add favourite error : $e");
    }
  }

  Future<void> deleteFavourite(int index) async {
    try {
      await favoriteBox.deleteAt(index);
    } catch (e) {
      throw Exception("delete favourite error : $e");
    }
  }

  Future<void> clearAllFavourites() async {
    try {
      await favoriteBox.clear();
    } catch (e) {
      throw Exception("clear all favourite error : $e");
    }
  }
}
