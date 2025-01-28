import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';
import 'package:skbwtrainer/themes/app_font.dart';

class ProfilePage extends StatelessWidget {
  final Gym gym;
  const ProfilePage({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TitleCard(
              title: 'Gym QR Code',
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.secondary,
                        theme.primary.withAlpha(50),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: sWidth*0.1),
                      Container(
                        height: sWidth * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: QrImageView(
                          data: gym.gymCode,
                          version: QrVersions.auto,
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: Colors.grey.shade900,
                          ),
                          dataModuleStyle: QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                      SizedBox(height: sWidth*0.1),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TitleCard(
              title: 'Gym Details',
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.secondary,
                        theme.primary.withAlpha(50),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.pix_rounded),
                        title: Text(
                          gym.name,
                          style: TextStyle(
                            color: theme.onSecondary,
                            fontFamily: AppFont.primaryFont,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          gym.phone,
                          style: TextStyle(
                            fontFamily: AppFont.primaryFont,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          gym.address,
                          style: TextStyle(
                            fontFamily: AppFont.primaryFont,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
