import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_states.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_page.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';
import 'package:skbwtrainer/utils/navigation.dart';

class MemberListPage extends StatelessWidget {
  final MemberRepo memberRepo = FireBaseMemberRepo();
  MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberCubit(memberRepo: memberRepo)..getMembers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Member List Page'),
        ),
        body: BlocConsumer<MemberCubit, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MembersLoaded) {
              return ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  final member = state.members[index];
                  return ListTile(
                    title: Text(member.name),
                    subtitle: Text(member.email),
                    trailing: Text(member.expiryDate.toString()),
                    onTap: () {
                      pushPage(context, MemberPage(member: member), 1);
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error loading members'),
              );
            }
          },
          listener: (context, state) {
            if (state is MemberError) {
              AppSnackBar.showError(state.message, context);
            }
          },
        ),
      ),
    );
  }
}
