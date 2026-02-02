import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'config/theme.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/templates/templates_list_screen.dart';
import 'screens/templates/add_template_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/templates': (context) => const TemplatesListScreen(),
        '/add-template': (context) => const AddTemplateScreen(),
      },
    );
  }
}
