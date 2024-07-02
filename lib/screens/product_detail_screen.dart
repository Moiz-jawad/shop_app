import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final loadedProduct =
        Provider.of<ProductProvider>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                fit: BoxFit.cover,
                loadedProduct.imageUrl,
                filterQuality: FilterQuality.high,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                loadedProduct.description,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
