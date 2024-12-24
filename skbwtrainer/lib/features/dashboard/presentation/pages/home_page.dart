import 'package:flutter/material.dart';
import 'package:skbwtrainer/features/dashboard/presentation/components/app_drawer.dart';
import 'package:skbwtrainer/themes/app_font.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      /// App bar
      appBar: AppBar(
        foregroundColor: theme.onPrimary,
        backgroundColor: theme.primary,
        centerTitle: true,
        title: Text(
          'Gymetry',
          style: TextStyle(fontFamily: AppFont.primaryFont),
        ),
      ),

      /// Drawer
      drawer: AppDrawer(),

      /// Body content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authenticated',
              style: TextStyle(fontFamily: AppFont.primaryFont),
            ),
          ],
        ),
      ),
    );
  }
}
