import 'package:flutter/material.dart';

Future pushPage(BuildContext context, Widget page, int direction) {
  return Navigator.push(context, createAnimatedRoute(page, direction));
}

Offset getOffset(int direction) {
  switch (direction) {
    case 1:
      return const Offset(1, 0);
    case 2:
      return const Offset(0, 1);
    case 3:
      return const Offset(-1, 0);
    case 4:
      return const Offset(0, -1);
    default:
      return const Offset(1, 0);
  }
}
Route createAnimatedRoute(Widget page, int? direction) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //
      final begin = getOffset(direction ?? 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}