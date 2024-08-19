import 'dart:convert';

import 'package:ecommarce/data/network/api_constants.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {

  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/${ApiConstants.categories}'));
      //debugPrint("fetch category : uri - ${Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/${ApiConstants.categories}')} ||\nresponse - ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        List<dynamic> categoriesJson = jsonDecode(response.body);
        // Casting each element in the list to String
        List<String> categories = categoriesJson.map((category) => category as String).toList();
        // debugPrint("categories : $categories");
        return categories;
      } else {
        throw Exception("fetch categories error");
      }
    } catch (e) {
      throw Exception("fetch categories exception : $e");
    }
  }

  Future<List<ProductDataModel>> fetchCategoryItem(String path) async{
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/${ApiConstants.category}/$path'));
      // debugPrint("fetch category item : uri - ${Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/${ApiConstants.category}/$path')} ||\nresponse - ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        List<dynamic> datum = jsonDecode(response.body);
        // Casting each element in the list to String
        List<ProductDataModel> categoryItems = datum.map((item) => ProductDataModel.fromJson(item)).toList();
        // debugPrint("categories item : $categoryItems");
        return categoryItems;
      } else {
        throw Exception("fetch categories item error");
      }
    } catch (e) {
      throw Exception("fetch categories item exception : $e");
    }
  }

}