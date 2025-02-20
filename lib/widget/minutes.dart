import 'package:flutter/material.dart';

class MinutesWidget extends StatelessWidget {
  final int defaultTime;

  MinutesWidget({
    super.key,
    required this.defaultTime,
  });

  int start = 15;
  final gap = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 5; i++)
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            width: 70,
            height: 50,
            child: Text(
              '${start + (i * gap)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
