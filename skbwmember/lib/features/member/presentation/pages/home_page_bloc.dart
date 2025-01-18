import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/auth/domain/entities/app_user.dart';
import 'package:skbwmember/features/member/data/firebase_member_repo.dart';
import 'package:skbwmember/features/member/domain/repositories/member_repo.dart';
import 'package:skbwmember/features/member/presentation/components/app_drawer.dart';
import 'package:skbwmember/features/member/presentation/cubits/member_cubit.dart';
import 'package:skbwmember/features/member/presentation/cubits/member_states.dart';
import 'package:skbwmember/features/member/presentation/pages/home_page.dart';
import 'package:skbwmember/theme/app_font.dart';

class HomePageBloc extends StatefulWidget {
  final AppUser user;
  const HomePageBloc({super.key, required this.user});

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  final MemberRepo memberRepo = FirebaseMemberRepo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          MemberCubit(memberRepo: memberRepo)..getMember(widget.user.uid),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.primary,
          foregroundColor: theme.onPrimary,
          title: Text(
            'SK Body Care',
            style: TextStyle(
              fontSize: 20,
              fontFamily: AppFont.primaryFont,
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: BlocConsumer<MemberCubit, MemberState>(builder: (context, state) {
          if (state is MemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MemberLoaded) {
            return HomePage(member: state.member);
          } else {
            return const Center(child: Text('No Data Found'));
          }
        }, listener: (context, state) {
          if (state is MemberError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
      ),
    );
  }
}
