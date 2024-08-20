import 'dart:convert';

import 'package:ecommarce/data/network/api_constants.dart';
import 'package:ecommarce/features/home/product/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeRepository{
  Future<List<ProductDataModel>> fetchProduct() async {
    try{
      Response response = await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.products),);
      // debugPrint("fetch product: uri - ${Uri.parse(ApiConstants.baseUrl + ApiConstants.products)} ||\nresponse - ${jsonDecode(response.body)}\n");

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<ProductDataModel> datum = data.map((item) => ProductDataModel.fromJson(item)).toList();
        // debugPrint("model data - ${jsonEncode(datum)}");
        return datum;
      }else{
        throw Exception("fetchProduct error: code - ${response.statusCode} || Throw server exception");
      }
    }catch(e){
      throw Exception("fetchProduct error: $e");
    }
  }

  Future<ProductDataModel> fetchProductDetails(int? productId) async {
    try{
      Response response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/$productId'),);
      debugPrint("fetch product: uri - ${Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/$productId')} ||\nresponse - ${jsonDecode(response.body)}");

      if(response.statusCode == 200){
        dynamic data = jsonDecode(response.body);
        ProductDataModel datum = ProductDataModel.fromJson(data);
        // debugPrint("model data - ${jsonEncode(datum)}");
        return datum;
      }else{
        throw Exception("fetchProductDetails error: code - ${response.statusCode} || Throw server exception");
      }
    }catch(e){
      throw Exception("fetchProductDetails error: $e");
    }
  }
}