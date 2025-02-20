import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Color colorRed;
  final String minutes;
  final String seconds;

  const TimerWidget({
    super.key,
    required this.colorRed,
    required this.minutes,
    required this.seconds,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
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
            widget.minutes,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorRed,
              fontSize: 100,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Text(
          ':',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 80,
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
            widget.seconds,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorRed,
              fontSize: 100,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
