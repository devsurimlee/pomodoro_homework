import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                'Hello World',
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
