import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import './providers/cart.dart';
import './screens/product_overview_screen.dart';
import './providers/product_provider.dart';
import 'providers/order.dart';
import 'screens/edit_product_screen.dart';
import 'screens/user_product_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          )),
          appBarTheme: AppBarTheme(
            color: Colors.deepOrangeAccent.shade200,
            foregroundColor: Colors.white,
          ),
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
