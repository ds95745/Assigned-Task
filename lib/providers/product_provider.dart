import 'package:flutter/material.dart';
import '../models/product.dart';
import '../network/api_service.dart';  // Import the API service

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get loading => _loading;

  final ApiService apiService = ApiService();

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      _products = await apiService.fetchProducts(); // Fetch products from API
    } catch (error) {
      print("Error fetching products: $error");
    } finally {
      _loading = false;
      notifyListeners(); // Notify listeners that loading is done
    }
  }
}
