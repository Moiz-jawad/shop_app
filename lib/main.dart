import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/cart.dart';
import './screens/product_overview_screen.dart';
import './providers/product_provider.dart';
import './providers/auth.dart';
import './providers/order.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_product_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (_) => ProductProvider('', []),
          update: (context, auth, previousItem) => ProductProvider(
            auth.token!,
            previousItem == null ? [] : previousItem.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, ch) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.deepOrange),
              ),
            ),
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
          home: AnimatedSplashScreen(
            duration: 1500,
            splash: const Icon(
              Icons.shopify,
              size: 150,
              color: Colors.white,
            ),
            nextScreen: auth.isAuth
                ? const ProductOverviewScreen()
                : const AuthScreen(),
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.deepOrange,
          ),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrderScreen.routeName: (context) => const OrderScreen(),
            UserProductScreen.routeName: (context) => const UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
