import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        child: BlurryContainer(
          padding: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(15),
          blur: 15,
          color: theme.secondary.withAlpha(150),
          elevation: 5,
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
              Tab(icon: Icon(Icons.restaurant)),
            ],
          ),
        ),
      ),
    );
  }
}
