import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ReplySenseApp());
}

class ReplySenseApp extends StatelessWidget {
  const ReplySenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ReplySense",
      theme: appTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
