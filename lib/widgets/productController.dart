import 'dart:convert';

import 'package:curd_api_project/models/productModel.dart';
import 'package:http/http.dart' as http;

import '../utils/urls.dart';

class ProductController {
  List<Data> products = [];

  Future<void> fetchProduct() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<void> createProduct(
    String productName,
    String img,
    int qty,
    int UnitPrice,
    int TotalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": UnitPrice,
        "TotalPrice": TotalPrice,
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      fetchProduct();
    }
  }

  Future<bool> DeleteProduct(String productId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productId)));

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateProduct(
      String id,
      String name,
      String img,
      int qty,
      int unitPrice,
      int totalPrice,
      ) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(id)), // make sure this returns the correct update URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    print("Update Status: ${response.statusCode}");

    if (response.statusCode == 200) {
      await fetchProduct();
    } else {
      throw Exception('Failed to update product');
    }
  }

}
