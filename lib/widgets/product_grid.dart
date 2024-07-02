import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(this.showFavroite, {super.key});
  final bool showFavroite;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products =
        showFavroite ? productData.favoriteItems : productData.items;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
