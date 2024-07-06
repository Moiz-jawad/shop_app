// import 'package:flutter/material.dart';

// class CustomTransiton<T> extends MaterialPageRoute<T> {
//   CustomTransiton({
//     required super.builder,
//     required RouteSettings super.settings,
//   });

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     if (settings.name == '/') {
//       return child;
//     }
//     return FadeTransition(
//       opacity: animation,
//       child: child,
//     );
//   }
// }

// class CustomPageTransitionBuilder extends PageTransitionsBuilder {
//   @override
//   Widget buildTransitions<T>(
//     PageRoute<T> route,
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     if (route.settings.name == '/') {
//       return child;
//     }
//     return FadeTransition(
//       opacity: animation,
//       child: child,
//     );
//   }
// }
