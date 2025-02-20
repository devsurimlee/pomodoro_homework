import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_homework/widget/minutes.dart';
import 'package:pomodoro_homework/widget/timer.dart';

class HomeScreen extends StatefulWidget {
  final Color pointColor;

  const HomeScreen({
    super.key,
    required this.pointColor,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const defaultTime = 25;
  static int totalSeconds = defaultTime * 60;
  bool isRunning = false;
  late Timer timer;

  void ontTick(Timer timer) {
    setState(() {
      totalSeconds--;
      print('totalSeconds: $totalSeconds');
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      ontTick,
    );

    setState(() {
      isRunning = true;
    });
  }

  String formatTime(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  "POMOTIMER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            TimerWidget(
              pointColor: widget.pointColor,
              minutes: formatTime(totalSeconds).split(':').first,
              seconds: formatTime(totalSeconds).split(':').last,
            ),
            const SizedBox(
              height: 50,
            ),
            MinutesWidget(
              defaultTime: defaultTime,
              pointColor: widget.pointColor,
            ),
            const SizedBox(
              height: 50,
            ),
            IconButton(
              onPressed: isRunning ? onPausePressed : onStartPressed,
              iconSize: 150,
              color: Colors.white,
              icon: Icon(isRunning
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline),
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '0/4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'ROUND',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '0/12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'GOAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
