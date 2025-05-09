import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_proyect/pages/Videos.dart';
import 'package:flutter/material.dart';
import 'package:final_proyect/pages/splashScreen.dart';
import 'package:final_proyect/pages/login_screen.dart'; // Asegúrate de importar tu LoginScreen
import 'package:final_proyect/pages/News.dart';
import 'package:final_proyect/pages/History.dart';
import 'package:final_proyect/pages/Home.dart';
import 'package:final_proyect/pages/Services.dart';
import 'package:final_proyect/pages/Shelters.dart';
import 'package:final_proyect/pages/Abous.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(), // Ruta para el login
        '/home': (context) =>
            const NavigationBar(), // Ruta para la app principal
      },
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 2; // Índice inicial centrado en Home
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    const News(),
    const History(),
    const Home(),
    const Services(),
    const Video(),
    // const MapScreen(),
    AcercaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentIndex,
        height: 60.0,
        items: const [
          Icon(Icons.newspaper, size: 30),
          Icon(Icons.history_edu_outlined, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.supervisor_account_sharp, size: 30),
          Icon(Icons.play_circle_outlined, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
