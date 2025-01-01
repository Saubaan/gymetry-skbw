import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_cubit.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Page'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            final memberCubit = context.read<MemberCubit>();
          },
          child: Text('Member Page'),
        ),
      ),
    );
  }
}
