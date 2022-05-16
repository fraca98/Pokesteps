import 'package:flutter/material.dart';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokesteps/screens/FoundPokemonPage.dart';
import 'package:pokesteps/widget/pokeloader.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/models/GeneratePokemon.dart';
import 'package:pokesteps/models/StepsCall.dart';

class Barsteps extends StatefulWidget {
  const Barsteps({Key? key}) : super(key: key);

  @override
  State<Barsteps> createState() => _BarstepsState();
}

class _BarstepsState extends State<Barsteps> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //if i have the response of the PokeApi i want to show the progress bar and the button to fetch steps
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20), //horizontal distance from margin
          child: Consumer<StepsCall>(
            builder: (context, value, child) => LinearPercentIndicator(
              lineHeight: 30, //height of the bar
              barRadius: const Radius.circular(20), //radius of the bar
              progressColor: const Color.fromARGB(255, 156, 199, 123),
              percent: min(
                  (Provider.of<StepsCall>(context, listen: false).getSumSteps /
                          Provider.of<GeneratePokemon>(context, listen: false)
                              .getStepstoHatch)
                      .toDouble(),
                  1), //get the minimum of 1 or steps/stepstohatch (else error if sumsteps>stepstohatch in displaying bar)
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(MdiIcons.shoePrint),
            const SizedBox(
              width: 10,
            ),
            Consumer<StepsCall>(
              builder: (context, value, child) => Text(
                'Steps: ${Provider.of<StepsCall>(context, listen: false).getSumSteps}/${Provider.of<GeneratePokemon>(context, listen: false).getStepstoHatch}', //formula to calculate the number of steps to hatch the egg
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 70,
          child: Center(
            child: Consumer<StepsCall>(
              builder: (context, value, child) => Provider.of<StepsCall>(
                              context,
                              listen: false)
                          .fetchbuttonloading ==
                      false
                  ? ElevatedButton( //if i'm not loading display the button
                      onPressed: () async {
                        Provider.of<StepsCall>(context, listen: false)
                            .updateFetchButtonLoading(); //set to true when loading
                        await Provider.of<StepsCall>(context, listen: false)
                            .authentication(); //may i perform authentication
                        await Provider.of<StepsCall>(context, listen: false)
                            .fetchsteps(); //i fetch the steps
                        if (Provider.of<StepsCall>(context, listen: false) //if i reached the number of steps to hatch the egg
                                .getSumSteps >=
                            Provider.of<GeneratePokemon>(context, listen: false)
                                .getStepstoHatch) {
                          Navigator.pushNamed(
                              context,
                              FoundPokemonPage
                                  .route); //go to the FoundPokemonPage
                        }
                        Provider.of<StepsCall>(context, listen: false)
                            .updateFetchButtonLoading(); //when finish loading set to false
                      },
                      child: Text(Provider.of<StepsCall>(context, listen: false)
                              .errorfetchsteps
                          ? 'Ops, an error occured, retry'
                          : 'Fetch your steps'), //If i have en error dispaly retry
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)),
                        elevation: 10,
                      ),
                    )
                  : const Pokeloader(), //if i'm loading display pokeloader
            ),
          ),
        ),
      ],
    );
  }
}
