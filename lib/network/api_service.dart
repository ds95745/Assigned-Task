import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

import '../models/product_response.dart';


class ApiService {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      ProductResponse productResponse = ProductResponse.fromJson(jsonResponse);
      return productResponse.products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
