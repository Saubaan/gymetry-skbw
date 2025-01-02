import 'package:flutter/material.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_bloc.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import '../../../../utils/navigation.dart';

class MemberListPage extends StatefulWidget {
  final List<Member> members;

  const MemberListPage({super.key, required this.members});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  String query = '';

  // get the expiry text for the member in months or days or expired
  String getExpiryText(DateTime expiryDate) {
    if (isExpired(expiryDate)) {
      return 'Subscription Expired!';
    }
    final days = expiryDate.difference(DateTime.now()).inDays;
    if (days > 30) {
      return 'Subscription expires in ${days ~/ 30} month ${days % 30} days';
    }
    return 'Subscription expires in $days days';
  }

  bool isExpired(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays < 0;
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
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TitleCard(
              children: [
                TextField(
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
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.secondary,
                borderRadius: BorderRadius.circular(sWidth / 30),
              ),
              height: sHeight,
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(sWidth / 30),
                      ),
                      child: ListTile(
                        title: Text(member.name,
                            style: TextStyle(fontFamily: AppFont.primaryFont)),
                        subtitle: Text(
                          getExpiryText(member.expiryDate),
                          style: TextStyle(
                            color: isExpired(member.expiryDate)
                                ? theme.error
                                : theme.onSecondary.withAlpha(150),
                            fontFamily: AppFont.logoFont,
                          ),
                        ),
                        onTap: () {
                          pushPage(context, MemberBloc(id: member.uid), 1);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
