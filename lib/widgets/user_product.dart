import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../providers/product_provider.dart';

class UserProduct extends StatelessWidget {
  const UserProduct(this.id, this.title, this.imageurl, {super.key});
  final String id;
  final String title;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      trailing: SizedBox(
        height: 100,
        width: 98,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(id)
                    .catchError((_) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('Delete failed!'),
                    ),
                  );
                });
              },
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
