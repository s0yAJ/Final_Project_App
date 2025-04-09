import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(40),
    child: Center(child: Column(children: [Text("Home: ")],),),);
  }
}