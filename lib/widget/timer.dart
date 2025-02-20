import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final Color colorRed;

  const TimerWidget({
    super.key,
    required this.colorRed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: 150,
          height: 150,
          child: Text(
            '10',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorRed,
              fontSize: 100,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Text(
          ':',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 100,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: 150,
          height: 150,
          child: Text(
            '30',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorRed,
              fontSize: 100,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
