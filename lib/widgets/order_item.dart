import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem(this.order, {super.key});
  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: _expanded
          ? min(widget.order.products.length * 20.0 + 120, double.infinity)
          : 125,
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(DateFormat('EE / dd / MM / yyyy   hh:mm')
                  .format(widget.order.dateTime)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: _expanded
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 15, 180)
                  : 0,
              child: ListView(
                children: widget.order.products.map((prod) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '   ${prod.title}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '  ${prod.quantity}x   \$${prod.price}  ',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
