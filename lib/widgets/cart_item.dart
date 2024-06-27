import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem(
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity, {
    super.key,
  });

  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 25),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete_outlined,
          color: Colors.white,
          size: 25,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  elevation: 7,
                  title: const Text('Are You Sure?'),
                  content: const Text('Do you Want to Remove this item'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yas'))
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeCart(productId);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '\$$price',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
