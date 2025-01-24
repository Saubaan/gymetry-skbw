import 'package:flutter/material.dart';

import '../theme/app_font.dart';

class TitleCard extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final MainAxisAlignment titleAlign;
  final CrossAxisAlignment childrenAlign;

  const TitleCard({
    super.key,
    this.title,
    required this.children,
    this.titleAlign = MainAxisAlignment.start,
    this.childrenAlign = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    List<Widget> columnChildren = [];
    if (title != null) {
      columnChildren.add(
        Row(
          mainAxisAlignment: titleAlign,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: sWidth / 20,
                fontFamily: AppFont.logoFont,
                color: theme.onSecondary,
              ),
            ),
          ],
        ),
      );
      columnChildren.add(const SizedBox(height: 10));
    }
    columnChildren.addAll(children);
    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(sWidth / 30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: childrenAlign,
        children: columnChildren,
      ),
    );
  }
}
