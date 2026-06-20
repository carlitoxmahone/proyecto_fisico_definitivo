import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          height: 1.35,
          color: Colors.white.withValues(alpha: 0.62),
        ),
      ),
    );
  }
}
