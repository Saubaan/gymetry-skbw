import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const Border(),
      child: SafeArea(
        child: ListView(
          children: const [
            ListTile(
              title: Text('Item 1'),
            ),
          ],
        ),
      ),
    );
  }
}
