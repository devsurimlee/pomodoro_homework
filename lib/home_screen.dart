import 'dart:async';
import 'package:flutter/material.dart';

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
  int selectedTime = 0; // 디폴트 시간
  int totalSeconds = 0;
  bool isRunning = false;

  late Timer timer;

  final minTime = 15;
  final timeGap = 5;

  bool isBreak = false;
  final breakTime = 5;

  int roundCount = 0;
  final roundLimit = 4;

  int goalCount = 0;
  final goalLimit = 12;

  @override
  void initState() {
    super.initState();
    selectedTime = 25; // 25
    totalSeconds = selectedTime * 60; // 1500
  }

  void doneTimer() {
    totalSeconds = selectedTime * 60;
    roundCount++;

    if (roundCount == roundLimit) {
      goalCount++;
      roundCount = 0;
    }
  }

  void ontTick(Timer timer) {
    setState(() {
      totalSeconds--;
      print('totalSeconds: $totalSeconds');
      print('isBreak $isBreak');

      // 1보다 작으면으로 변경하기 FIXME
      if (totalSeconds % 10 == 7) {
        onPausePressed();

        if (isBreak) {
          // 쉬는시간 이었음
          totalSeconds = selectedTime * 60;
          isBreak = false;
        } else {
          // 쉬는시간 아님
          totalSeconds = breakTime * 60;
          isBreak = true;
          doneTimer();
          onStartPressed();
        }
      }
    });
  }

  void resetAll() {
    selectedTime = 25;
    totalSeconds = selectedTime * 60;
    roundCount = 0;
    goalCount = 0;
    onPausePressed();
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

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String formatTime(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  //////////////////////////
  void changeTime(int time) {
    setState(() {
      selectedTime = time;
      totalSeconds = selectedTime * 60;
      print('changeTime $time');
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
              height: 50,
            ),
            ///// timer start
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: 150,
                  height: 150,
                  child: Text(
                    formatTime(totalSeconds).split(':').first,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.pointColor,
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
                    formatTime(totalSeconds).split(':').last,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.pointColor,
                      fontSize: 100,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            ///// timer end
            const SizedBox(
              height: 50,
            ),
            // Minutes start
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 5; i++)
                  GestureDetector(
                    onTap: () => changeTime(minTime + (i * timeGap)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTime == (minTime + (i * timeGap))
                            ? Colors.white
                            : widget.pointColor,
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      width: 70,
                      height: 50,
                      child: Text(
                        '${minTime + (i * timeGap)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTime == (minTime + (i * timeGap))
                              ? widget.pointColor
                              : Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            ////// Minutes end
            ///

            const SizedBox(
              height: 50,
            ),

            SizedBox(
                height: 160,
                child: isBreak
                    ? const Text(
                        "Break Time!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : IconButton(
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        iconSize: 150,
                        color: Colors.white,
                        icon: Icon(isRunning
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline),
                      )),

            const SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '$roundCount/$roundLimit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
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
                      '$goalCount/$goalLimit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
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
