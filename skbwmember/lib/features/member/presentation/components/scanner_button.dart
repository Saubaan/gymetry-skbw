import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/features/member/presentation/cubits/attendance_cubit.dart';
import 'package:skbwmember/features/member/presentation/pages/scanner_page.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';

class ScannerButton extends StatefulWidget {
  final String memberUID;
  final bool isMarked;
  const ScannerButton({super.key, required this.memberUID, required this.isMarked});

  @override
  State<ScannerButton> createState() => _ScannerButtonState();
}

class _ScannerButtonState extends State<ScannerButton> {
  String codeValue = '';

  Future<String> getScanCode() async {
    final code = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScannerPage()));
    setState(() {
      if (code != null) {
        codeValue = code;
      }
    });
    return codeValue;
  }

  Future<void> handleScanPermission() async {
    final attendanceCubit = context.read<AttendanceCubit>();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        final code = await getScanCode();
        if (code.isNotEmpty) {
          attendanceCubit.markAttendance(widget.memberUID, code);
        }
      } else {
        throw Exception('Camera permission denied');
      }
    } else if (status.isGranted) {
      final code = await getScanCode();
      if (code.isNotEmpty) {
        attendanceCubit.markAttendance(widget.memberUID, code);
      }
    } else {
      throw Exception('Camera permission denied');
    }
  }

  void markAttendance() async {
    try {
      handleScanPermission();
    } catch (e) {
      AppSnackBar.showError(e.toString(), context);
    }
  }

  void marked() {
    AppSnackBar.showInfo('Attendance already marked', context);
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Scan QR Code',
      onTap: widget.isMarked ? marked : markAttendance,
      color: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
