import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_proyect/pages/History.dart';
import 'package:final_proyect/pages/Home.dart';
import 'package:final_proyect/pages/Services.dart';
import 'package:final_proyect/pages/Shelters.dart';
import 'package:flutter/material.dart';

import 'pages/News.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: !true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Navigation_bar(),
    );
  }
}

class Navigation_bar extends StatefulWidget {
  const Navigation_bar({super.key});

  @override
  State<Navigation_bar> createState() => _Navigation_barState();
}

class _Navigation_barState extends State<Navigation_bar> {
  int pageNum = 0;
  final keynavigation = GlobalKey<CurvedNavigationBarState>();

  final ICONS = [
    const Icon(Icons.newspaper),
    const Icon(Icons.history_edu_outlined),
    const Icon(Icons.home),
    const Icon(Icons.supervisor_account_sharp),
    const Icon(Icons.location_pin),
  ];

  final screen = [
    News(),
    History(),
    Home(),
    Services(),
    Shelters(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: screen[pageNum],
      bottomNavigationBar: CurvedNavigationBar(
        key: keynavigation,
        backgroundColor: Colors.transparent,
        items: ICONS,
        animationDuration: const Duration(milliseconds: 700),
        index: pageNum,
        onTap: (index) {
          setState(() {
            pageNum = index;
          });
        },
      ),
    );
  }
}
