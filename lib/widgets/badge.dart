// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'package:flutter/material.dart';

class Baadge extends StatelessWidget {
  const Baadge({
    super.key,
    this.color = Colors.deepOrange,
    required this.child,
    required this.value,
  });
  final Color color;
  final Widget child;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : color,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
