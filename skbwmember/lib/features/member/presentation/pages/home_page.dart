import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/auth/domain/entities/app_user.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';

class HomePage extends StatefulWidget {
  final AppUser user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),

          /// debug button to modify attributes of member documents at once
          // IconButton(
          //   onPressed: () {
          //     final FirebaseFirestore firestore = FirebaseFirestore.instance;
          //     firestore.collection('members').get().then((snapshot) {
          //       for (final doc in snapshot.docs) {
          //          doc.reference.update({'checkDate': Timestamp.now()});;
          //       }
          //     });
          //   },
          //   icon: const Icon(Icons.add),
          // )
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
