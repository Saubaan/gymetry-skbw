import 'package:flutter/material.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/approval/presentation/components/request_tab.dart';
import 'package:skbwtrainer/features/auth/domain/entities/app_user.dart';
import 'package:skbwtrainer/features/member/presentation/components/app_drawer.dart';
import 'package:skbwtrainer/features/member/presentation/components/day_analytic_bloc.dart';
import 'package:skbwtrainer/features/member/presentation/components/weekly_analytics_bloc.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_list_bloc.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/navigation.dart';

class HomePage extends StatefulWidget {
  final AppUser user;
  const HomePage({super.key, required this.user});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Greeting
              TitleCard(
                children: [
                  Row(
                    children: [
                      Text(
                        'Hello there,',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.primaryFont,
                          color: theme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFont.primaryFont,
                          color: theme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              RequestTab(),

              // Weekly Analytics
              TitleCard(
                title: 'Weekly Analytics',
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: theme.onSecondary.withAlpha(50), width: 2),
                      gradient: LinearGradient(
                        colors: [
                          theme.secondary,
                          theme.surface,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: WeeklyAnalyticsBloc(),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Today Overview
              TitleCard(
                title: 'Today Overview',
                children: [
                  Row(
                    children: [
                      Divider(),
                      DayAnalyticBloc(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Management
              TitleCard(
                title: 'Management',
                children: [
                  PrimaryButton(
                    // color: theme.onSecondary,
                    // textColor: theme.secondary,
                    color: theme.primary,
                    textColor: theme.onPrimary,
                    text: 'View all Members',
                    onTap: () {
                      pushPage(context, MemberListBloc(), 1);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
