import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pokesteps/screen/LoginPage.dart';

class WelcomePage extends StatelessWidget {
  static const route = '/WelcomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.yellow,
                Colors.red,
                Colors.indigo,
                Colors.teal,
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1200px-International_Pok%C3%A9mon_logo.svg.png',
                  scale: 0.5,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
