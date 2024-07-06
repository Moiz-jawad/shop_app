import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/splash_screen.dart';

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
import 'transaction/custom_transition.dart';

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
          create: (_) => ProductProvider('', '', []),
          update: (_, auth, previousItem) => ProductProvider(
            auth.token.toString(),
            auth.userId.toString(),
            previousItem == null ? [] : previousItem.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (_) => Order('', '', []),
          update: (_, auth, previousOrders) => Order(
            auth.token.toString(),
            auth.userId.toString(),
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, ch) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
            }),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.deepOrange),
            elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                animationDuration: Durations.long1,
                elevation: MaterialStatePropertyAll(9),
                backgroundColor: MaterialStatePropertyAll(
                  Colors.deepOrange,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
              ),
            ),
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
          home: auth.isAuth
              ? const ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen(),
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
