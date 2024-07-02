import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/side_drawer.dart';
import '../widgets/user_product.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/user';

  Future<void> refreshProduct(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: RefreshIndicator(
        color: Colors.deepOrange,
        edgeOffset: BorderSide.strokeAlignCenter,
        onRefresh: () => refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: productdata.items.length,
            itemBuilder: (_, i) => UserProduct(
              productdata.items[i].id,
              productdata.items[i].title,
              productdata.items[i].imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
