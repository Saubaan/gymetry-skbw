import 'package:flutter/material.dart';
import 'package:skbwtrainer/features/approval/data/firebase_approval_repo.dart';
import 'package:skbwtrainer/features/approval/domain/entities/pending_member.dart';
import 'package:skbwtrainer/features/member/presentation/components/app_drawer.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_list_bloc.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/navigation.dart';

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
            ElevatedButton(
              onPressed: () {
                pushPage(context, MemberListBloc(), 1);
              },
              child: Text(
                'Show members',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                PendingMember pendingMember = PendingMember(
                  name: 'John Doe',
                  email: 'john@doe.com',
                  password: 'password',
                  phone: '1234567890',
                  createdAt: DateTime.now(),
                  expiryDate: DateTime.now().add(Duration(days: 30)),
                );
                await FirebaseApprovalRepo()
                    .createPendingMember(pendingMember);
              },
              child: Text(
                'create member',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
