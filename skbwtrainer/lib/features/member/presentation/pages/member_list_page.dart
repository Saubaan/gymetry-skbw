import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/presentation/components/member_tile.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_bloc.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/navigation.dart';

class MemberListPage extends StatefulWidget {
  final List<Member> members;

  const MemberListPage({super.key, required this.members});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  String query = '';

  void navigateToMemberDetails(String uid) async {
    final memberCubit = context.read<MemberCubit>();
    await pushPage(context, MemberBloc(uid: uid), 1);
    memberCubit.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).colorScheme;

    final filteredMembers = widget.members
        .where(
            (member) => member.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredMembers.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));

    return Scaffold(
      backgroundColor: theme.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.secondary,
        title: TextField(
          style: TextStyle(fontFamily: AppFont.primaryFont),
          onChanged: (value) {
            setState(
                  () {
                query = value;
              },
            );
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: AppFont.primaryFont,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondary
                    .withAlpha(150),
                fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter member name',
            prefixIcon: Icon(Icons.search,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondary
                    .withAlpha(150)),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(sWidth, sHeight / 16),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Total members: ${filteredMembers.length}',
              style: TextStyle(
                fontFamily: AppFont.primaryFont,
                color: theme.onSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      body: widget.members.isEmpty
          ? Center(
              child: Text(
                'No members found',
                style: TextStyle(
                  fontFamily: AppFont.primaryFont,
                  color: theme.onSecondary,
                ),
              ),
            )
          : ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(sWidth / 30),
                    ),
                    child: MemberTile(
                      member: member,
                      onTap: () => navigateToMemberDetails(member.uid),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
