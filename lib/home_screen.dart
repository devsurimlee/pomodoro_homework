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

  int minTime = 1; // 25
  final timeGap = 1; // 5

  int roundCount = 0;
  final roundLimit = 4; // 사이클

  int goalCount = 0;
  final goalLimit = 12;

  @override
  void initState() {
    super.initState();
    selectedTime = 3; // 25
    totalSeconds = selectedTime * 60;
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

      // 1보다 작으면으로 변경하기
      if (totalSeconds % 10 == 8) {
        // 1로 변경하기
        onPausePressed();
        doneTimer();
      }
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

  //////////////////////////
  void tapMinutesButton(int time) {
    setState(() {
      selectedTime = time;
      totalSeconds = selectedTime * 60;
      print('tapMinutesButton $time');
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
                    onTap: () => tapMinutesButton(minTime + (i * timeGap)),
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
