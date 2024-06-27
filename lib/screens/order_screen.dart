import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/order.dart' show Order;
import '../widgets/side_drawer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLaoding = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLaoding = true;
      });
      Provider.of<Order>(context, listen: false).fetchAndSetOrders().then((_) {
        setState(() {
          _isLaoding = false;
        });
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
      body: _isLaoding
          ? const Align(
              child: CircularProgressIndicator(
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
