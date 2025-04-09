import 'package:flutter/material.dart';

class Shelters extends StatefulWidget {
  const Shelters({super.key});

  @override
  State<Shelters> createState() => SsheltersState();
}

class SsheltersState extends State<Shelters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [Text("Shelters: ")],
        ),
      ),
    );
  }
}
