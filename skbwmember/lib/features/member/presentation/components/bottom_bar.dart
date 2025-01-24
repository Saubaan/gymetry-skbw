import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
          color: theme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabBar(
          indicatorColor: theme.primary,
          labelColor: theme.primary,
          dividerHeight: 0,
          unselectedLabelColor: theme.onSecondary,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorAnimation: TabIndicatorAnimation.elastic,
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.fitness_center)),
          ],
        ),
      ),
    );
  }
}
