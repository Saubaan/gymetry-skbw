import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, this.color = Colors.white, this.textColor, this.onTap, this.fontSize});
  final String text;
  final void Function()? onTap;
  final double? fontSize;
  final Color color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(sWidth / 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sWidth / 40),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? sWidth / 18,
                color:
                textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontFamily: 'Retroica',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
