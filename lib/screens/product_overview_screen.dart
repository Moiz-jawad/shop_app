// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';

import '../providers/cart.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/side_drawer.dart';

enum FliterOptions {
  favorite,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .fetchAndSetProduct()
          .catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Oops!',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            content: const Text('Something went wrong'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShopify'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FliterOptions selectValue) {
              setState(() {
                if (selectValue == FliterOptions.favorite) {
                  _showFavorite = true;
                } else {
                  _showFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FliterOptions.favorite,
                child: Text('Favorite'),
              ),
              const PopupMenuItem(
                value: FliterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Baadge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart_checkout),
            ),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: _isLoading
          ? const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                color: Colors.deepOrange,
              ),
            )
          : ProductGrid(_showFavorite),
    );
  }
}
