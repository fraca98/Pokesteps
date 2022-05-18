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
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.4,
                0.5,
                0.6,
                0.8,
              ],
              colors: [
                Color.fromARGB(251, 250, 248, 248),
                Colors.yellow,
                Colors.red,
                Colors.orange,
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/pokesteps.jpg',
                  scale: 0.5,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              SizedBox(
                height: 95.0,
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginPage.route),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.black),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
