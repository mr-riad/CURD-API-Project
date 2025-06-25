import 'dart:convert';

import 'package:curd_api_project/models/productModel.dart';
import 'package:http/http.dart' as http;

import '../utils/urls.dart';

class ProductController{
  List<Data> products =[];

  Future<void> fetchProduct()async{
    final response = await http.get(Uri.parse(Urls.readProduct));

    print(response.statusCode);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
  }
}