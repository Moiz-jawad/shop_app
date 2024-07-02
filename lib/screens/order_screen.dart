import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/order.dart' show Order;
import '../widgets/side_drawer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static const routeName = '/order';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  @override
  void initState() {
    setState(() {
      _isloading = true;
    });
    Provider.of<Order>(context, listen: false).fetchAndSetOrders().then((_) {
      setState(() {
        _isloading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const SideDrawer(),
      body: _isloading
          ? const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                color: Colors.deepOrange,
              ),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) => OrderItem(
                orderData.orders[index],
              ),
            ),
    );
  }
}
