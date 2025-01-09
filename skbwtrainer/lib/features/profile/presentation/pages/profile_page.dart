import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';

import '../../../../themes/app_font.dart';

class ProfilePage extends StatelessWidget {
  final Gym gym;
  const ProfilePage({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: AppFont.primaryFont),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleCard(
                title: 'Gym Details',
                childrenAlign: CrossAxisAlignment.start,
                children: [
                  Text(
                    gym.name,
                    style: TextStyle(fontFamily: AppFont.primaryFont),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone: ${gym.phone}',
                    style: TextStyle(fontFamily: AppFont.primaryFont),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 10),
              TitleCard(
                title: 'Gym QR Code',
                children: [
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: QrImageView(
                      data: gym.gymCode,
                      version: QrVersions.auto,
                      embeddedImage: (AssetImage('assets/logo/logo-w.png')),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(40, 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Code: ${gym.gymCode}',
                    style: TextStyle(fontFamily: AppFont.primaryFont),
                  ),
                  SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
