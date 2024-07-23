import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_item.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(product: products[i]),
    );
  }
}
