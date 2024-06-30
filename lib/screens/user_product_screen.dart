import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/side_drawer.dart';
import '../widgets/user_product.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/user';

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
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
      body: FutureBuilder(
        future: refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 6.5,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => refreshProducts(context),
                    child: Consumer<ProductProvider>(
                      builder: (context, productData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (ctx, i) => UserProduct(
                            productData.items[i].id,
                            productData.items[i].title,
                            productData.items[i].imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
