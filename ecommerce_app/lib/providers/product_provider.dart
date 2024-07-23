import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isFetching = false;

  List<Product> get products => _products;
  bool get isFetching => _isFetching;

  Future<void> fetchProducts() async {
    _isFetching = true;
    notifyListeners();
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productData = json.decode(response.body);
      _products = productData.map((item) => Product.fromJson(item)).toList();
      _isFetching = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
