import 'package:flutter/material.dart';

class Barsteps extends StatefulWidget {
  const Barsteps({Key? key}) : super(key: key);

  @override
  State<Barsteps> createState() => _BarstepsState();
}

class _BarstepsState extends State<Barsteps> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Here i have to put bar steps and fetch of fitbit data button'),
      ],
    );
  }
}
