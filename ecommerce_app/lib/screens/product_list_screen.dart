import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/product_item.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> _products = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _page = 0;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchProducts();
      }
    });
  }

  Future<void> _fetchProducts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    final products = await ApiService().fetchProducts(_page * _limit, _limit);
    setState(() {
      _products.addAll(products);
      _isLoading = false;
      _page++;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _products.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _products.length) {
            return const Center(child: CircularProgressIndicator());
          }
          return ProductItem(product: _products[index]);
        },
      ),
    );
  }
}
