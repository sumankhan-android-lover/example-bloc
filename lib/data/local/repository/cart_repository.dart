import 'dart:convert';

import 'package:ecommarce/features/home/cart/model/cart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartRepository {
  final Box<CartDataModel> cartBox;

  CartRepository(this.cartBox);

  List<CartDataModel> getCartItems() {
    try {
      List<CartDataModel> items = cartBox.values.toList();

      // If you want to debug-print the items in JSON format:
      List<Map<String, dynamic>> jsonItems = items.map((item) => item.toJson()).toList();
      debugPrint("get cart items data - ${json.encode(jsonItems)}");
      //end

      return items;
    } catch (e) {
      throw Exception("get cart item error : $e");
    }
  }

  Future<Map<String, dynamic>> addItem(CartDataModel item) async {
    try {
      await cartBox.put(item.id, item);
      return {
        "status" : true,
        "success" : "Added item successfully"
      };
    } catch (e) {
      throw Exception("add cart item error : $e");
    }
  }

  Future<Map<String, dynamic>> updateItem(CartDataModel item) async {
    try {
      await cartBox.put(item.id, item);
      return {
        "status" : true,
        "success" : "Updated item successfully"
      };
    } catch (e) {
      throw Exception("update cart item error : $e");
    }
  }

  Future<Map<String, dynamic>> removeItem(int id) async {
    try {
      await cartBox.delete(id);
      return {
        "status" : true,
        "success" : "Deleted item successfully"
      };
    } catch (e) {
      throw Exception("remove cart item error : $e");
    }
  }

  Future<Map<String, dynamic>> clearCart() async {
    try {
      await cartBox.clear();
      return {
        "status" : true,
        "success" : "All item cleared"
      };
    } catch (e) {
      throw Exception("clear cart item error : $e");
    }
  }
}
