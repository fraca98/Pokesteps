import 'package:flutter/material.dart';

class Pokeloader extends StatelessWidget {
  const Pokeloader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
              'assets/images/pokeloader.gif', //pokeloader gif (pokeball rotating-->while fetching)
              fit: BoxFit.contain, //to avoid distorsion
            );
  }
}