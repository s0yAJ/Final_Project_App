import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_proyect/pages/News.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageNum = 0;

  final ICONS = [
    const Icon(Icons.people_alt),
    const Icon(Icons.person_add),
    const Icon(Icons.home),
    const Icon(Icons.insert_chart_outlined_rounded),
    const Icon(Icons.home),
  ];
  
  final screen =[
    News(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[900],
      body: screen[pageNum],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: ICONS),
    );
  }
}