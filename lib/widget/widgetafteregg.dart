import 'package:flutter/material.dart';
import 'package:pokesteps/widget/barsteps.dart';
import 'package:pokesteps/widget/pokeloader.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/models/GeneratePokemon.dart';


class widgetafteregg extends StatefulWidget {
  const widgetafteregg({ Key? key }) : super(key: key);

  @override
  State<widgetafteregg> createState() => _widgetaftereggState();
}

class _widgetaftereggState extends State<widgetafteregg> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratePokemon>(
      builder: (context, value, child) => Provider.of<GeneratePokemon>(context,
                      listen: false)
                  .getResponsePokeApi ==
              null
          ? Pokeloader() //if it's null the response of PokeApi i want to show a loader (maybe is loading or error)
          : Barsteps() //else i want to show the bar and buttons to perform the fetch of the steps
    );
  }
}