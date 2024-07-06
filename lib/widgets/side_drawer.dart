import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 105,
            width: double.infinity,
            color: Colors.deepOrange,
            padding: const EdgeInsets.all(25),
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.shop,
              color: Colors.deepOrange,
            ),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.deepOrange,
            ),
            title: const Text('Payment'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit_square,
              color: Colors.deepOrange,
            ),
            title: const Text('User Manage'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.deepOrange,
            ),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
