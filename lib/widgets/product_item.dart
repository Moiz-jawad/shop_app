import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          header: Container(
            color: Colors.black45,
            child: Text(
              style: const TextStyle(color: Colors.white),
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: const Color.fromARGB(200, 0, 0, 0),
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red.shade400),
                onPressed: () {
                  product.toogleFavorite();
                },
              ),
            ),
            title: Text(
              product.price.toString(),
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.title,
                    product.price,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Added into cart'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          }),
                    ),
                  );
                }),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
