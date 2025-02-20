import 'package:flutter/material.dart';

class MinutesWidget extends StatefulWidget {
  final int defaultTime;
  final Color pointColor;

  const MinutesWidget({
    super.key,
    required this.defaultTime,
    required this.pointColor,
  });

  @override
  State<MinutesWidget> createState() => _MinutesWidgetState();
}

class _MinutesWidgetState extends State<MinutesWidget> {
  int start = 15;
  final gap = 5;

  int selectedButtonIndex = 0;

  void tapMinutesButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = -2; i < 3; i++)
          GestureDetector(
            onTap: () => tapMinutesButton(i),
            child: Container(
              decoration: BoxDecoration(
                color:
                    selectedButtonIndex == i ? Colors.white : widget.pointColor,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              width: 70,
              height: 50,
              child: Text(
                '${widget.defaultTime + (i * 5)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedButtonIndex == i
                      ? widget.pointColor
                      : Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
