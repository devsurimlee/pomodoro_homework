import 'package:flutter/material.dart';
import 'package:pomodoro_homework/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const colorRed = Color(0xFFe64d3d);

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: colorRed,
      ),
      home: const HomeScreen(
        colorRed: colorRed,
      ),
    );
  }
}
