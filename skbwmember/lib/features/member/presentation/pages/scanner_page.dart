import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:skbwmember/theme/app_font.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController controller = MobileScannerController();
  bool flash = false;

  void toggleFlash() {
    controller.toggleTorch();
    setState(() {
      flash = !flash;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.tertiary),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: MobileScanner(
                              controller: controller,
                              onDetect: (BarcodeCapture capture) async {
                                final List<Barcode> barcodes = capture.barcodes;
                                if (barcodes.isNotEmpty) {
                                  String code =
                                      barcodes.first.rawValue ?? 'Unknown';
                                  await controller.stop();
                                  if (context.mounted) {
                                    Navigator.pop(context, code);
                                  }
                                }
                              },
                            ),
                          ),
                          Container(
                            height: sWidth / 2,
                            width: sWidth / 2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: theme.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Scan Gym QR Code',
                          style: TextStyle(
                            color: Colors.grey.shade50,
                            fontFamily: AppFont.primaryFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: toggleFlash,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: flash ? theme.primary : theme.secondary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            flash ? Icons.flashlight_on : Icons.flashlight_off,
                            color: flash ? theme.onPrimary : theme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
