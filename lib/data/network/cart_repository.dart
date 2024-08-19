import 'dart:convert';

import 'package:ecommarce/data/network/api_constants.dart';
import 'package:ecommarce/features/home/cart/model/add_cart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CartRepository{
  Future<AddCartDataModel> addToCart(int? userId, String date, Map<String, dynamic> data) async {
    debugPrint("addToCart api call");
    try{
      Map<String, dynamic> param = {
        "userId": userId,
        "date": date,
        "products": [data]
      };
      // Encode the parameters to a JSON string
      String requestBody = json.encode(param);

      // debugPrint("body - $requestBody");
      Response response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.carts}'),
          headers: {"Content-Type": "application/json"},
          body: requestBody
      );
      // debugPrint("response - ${json.encode(param)}");
      debugPrint("add to cart: uri - ${Uri.parse('${ApiConstants.baseUrl}${ApiConstants.carts}')} ||\nbody - $requestBody ||\nresponse - ${jsonDecode(response.body)}");

      if(response.statusCode == 200){
        dynamic data = jsonDecode(response.body);
        AddCartDataModel datum = AddCartDataModel.fromJson(data);
        debugPrint("model data - ${jsonEncode(datum)}");
        return datum;
      }else{
        throw Exception("addToCart error: code - ${response.statusCode} || Throw server exception");
      }
    }catch(e){
      throw Exception("addToCart error: $e");
    }
  }
}