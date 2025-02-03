import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        centerTitle: true,
        title: Text(
          'About Bitvert',
          style: TextStyle(
            fontFamily: AppFont.primaryFont,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Greeting
              TitleCard(
                title: 'Hello, there!',
                childrenAlign: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I am Saubaan Shaikh from Bitvert.\n'
                    'This app was developed by me with the help of my team for our client Mr. Shoaib Shaikh.\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFont.logoFont,
                      color: theme.onSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TitleCard(children: [
                Text(
                  'Bitvert is a team of freelance developers who are passionate about building '
                  'applications that are not only visually appealing but also '
                  'provide a great user experience.\n\nYou need an app or website for your '
                  'business? \nWe can help you with that.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: AppFont.logoFont,
                    color: theme.onSecondary,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              TitleCard(
                title: 'Our Current Team',
                children: [
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://saubaan.github.io/profile.png',
                      ),
                    ),
                    title: Text('Saubaan Shaikh',
                        style: TextStyle(
                            fontSize: 18, fontFamily: AppFont.primaryFont)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile App Developer, UI/UX Designer',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(theme.primary),
                            backgroundColor: WidgetStateProperty.all(theme.surface),
                          ),
                          onPressed: () {
                            try {
                              launchUrl('https://saubaan.github.io');
                            } catch (e) {
                              AppSnackBar.showError(e.toString(), context);
                            }
                          },
                          child: Text('Visit Portfolio'),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://rush4n.github.io/profile.jpg',
                      ),
                    ),
                    title: Text('Rushan Shaikh',
                        style: TextStyle(
                            fontSize: 18, fontFamily: AppFont.primaryFont)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Web Developer, Backend Developer',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(theme.primary),
                            backgroundColor: WidgetStateProperty.all(theme.surface),
                          ),
                          onPressed: () {
                            try {
                              launchUrl('https://rush4n.github.io');
                            } catch (e) {
                              AppSnackBar.showError(e.toString(), context);
                            }
                          },
                          child: Text('Visit Portfolio'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TitleCard(
                title: 'Contact Us',
                children: [
                  Text(
                    'If you have a plan to build an app or website for you, '
                    'We can build it for you.\n\n'
                    'You can contact us via email or visit our website to get in touch with us.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFont.logoFont,
                      color: theme.onSecondary,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email, color: theme.onSurface),
                    title: Text(
                      'bitvert.tech@gmail.com',
                      style: TextStyle(
                          fontSize: 14, fontFamily: AppFont.primaryFont),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.copy, size: 20,),
                      onPressed: () {
                        copyToClipboard(context, 'bitvert.tech@gmail.com');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
