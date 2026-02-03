import 'package:flutter/material.dart';
import 'wireframe_screens.dart';

/// WIREFRAME VERSION - Low Fidelity Mockup
/// Colors: Black, White, Grays only
/// Purpose: Design reference for Stitch AI / Figma AI

void main() {
  runApp(const WireframeApp());
}

class WireframeApp extends StatelessWidget {
  const WireframeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReplySense Wireframe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
      ),
      home: const WireframeNavigator(),
    );
  }
}

class WireframeNavigator extends StatefulWidget {
  const WireframeNavigator({super.key});

  @override
  State<WireframeNavigator> createState() => _WireframeNavigatorState();
}

class _WireframeNavigatorState extends State<WireframeNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WireframeLogin(),
    const WireframeDashboard(),
    const WireframeSmartReplies(),
    const WireframeTemplates(),
    const WireframeProfile(),
  ];

  final List<String> _titles = [
    'Login Screen',
    'Dashboard',
    'Smart Replies',
    'Templates',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF2563EB),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Replies'),
            BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Templates'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
