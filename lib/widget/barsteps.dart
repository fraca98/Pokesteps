import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokesteps/models/PokeTrainerProvider.dart';
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
        SizedBox(
          height: MediaQuery.of(context).size.height*0.04,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height*0.03), //horizontal distance from margin
          child: Consumer<StepsCall>(
            builder: (context, value, child) => LinearPercentIndicator(
              lineHeight: 30, //height of the bar
              barRadius: Radius.circular(20), //radius of the bar
              progressColor: Color.fromARGB(255, 156, 199, 123),
              percent: min(
                  (Provider.of<StepsCall>(context, listen: false).getSumSteps /
                          Provider.of<GeneratePokemon>(context, listen: false)
                              .getStepstoHatch)
                      .toDouble(),
                  1), //get the minimum of 1 or steps/stepstohatch (else error if sumsteps>stepstohatch in displaying bar)
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.shoePrint),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.02,
            ),
            Consumer<StepsCall>(
              builder: (context, value, child) => Text(
                'Steps: ${Provider.of<StepsCall>(context, listen: false).getSumSteps}/${Provider.of<GeneratePokemon>(context, listen: false).getStepstoHatch}', //formula to calculate the number of steps to hatch the egg
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.03,
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Consumer<StepsCall>(
                builder: (context, value, child) => Provider.of<StepsCall>(
                                context,
                                listen: false)
                            .fetchbuttonloading ==
                        false
                    ? ElevatedButton(
                        //if i'm not loading display the button
                        onPressed: () async {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          Provider.of<StepsCall>(context, listen: false)
                              .updateFetchButtonLoading(); //set to true when loading
                          
                          if (await InternetConnectionChecker().hasConnection == true){        
                          if (Provider.of<StepsCall>(context, listen: false)
                                  .firstabsolutefetch ==
                              true) {
                            //first absolute fetch for that egg
                            await Provider.of<StepsCall>(context, listen: false)
                                .authorizationFitbit();
        
                            Provider.of<StepsCall>(context, listen: false)
                                    .startdate =
                                DateTime
                                    .now(); //set startdate to fetch steps for the first time of this egg (need to remove previous steps of the day: cause i have daily data)
                            //print(Provider.of<StepsCall>(context, listen: false).startdate);
        
                            await Provider.of<StepsCall>(context, listen: false)
                                .fetchsteps(); //i fetch the steps start to remove the first time i get the egg
        
                          } else {
                            await Provider.of<StepsCall>(context, listen: false)
                                .authorizationFitbit();
                            await Provider.of<StepsCall>(context, listen: false)
                                .fetchsteps();
                            if (Provider.of<StepsCall>(context, listen: false)
                                    .getSumSteps >=
                                Provider.of<GeneratePokemon>(context,
                                        listen: false)
                                    .getStepstoHatch) {
        
                              await Provider.of<GeneratePokemon>(context,listen: false).updateopenlastegg(); //update database setting the last egg as open
                              await Provider.of<PokeTrainerProvider>(context, listen: false).showLoader(); //show the loader for Pokédex refresh
                              await Provider.of<PokeTrainerProvider>(context, listen: false).updatenumberpokedex(); //refresh the number of Pokémon in Pokédex and refresh the entire Pokédex
                              Navigator.pushReplacementNamed(context,FoundPokemonPage.route); //if number of steps >= steps to hatch the egg                           
                            }
                          }
                          }else{
                             final snackbar = SnackBar(content: Row(children: [
                                    Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text('No internet connection available')],
                                    ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),);
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          Provider.of<StepsCall>(context, listen: false)
                              .updateFetchButtonLoading(); //when finish loading set to false
                        },
                        child: Text(Provider.of<StepsCall>(context, listen: false)
                                .errorfetchsteps
                            ? Provider.of<StepsCall>(context, listen: false).errorMessage
                            : (Provider.of<StepsCall>(context, listen: false)
                                    .firstabsolutefetch
                                ? "Let's start"
                                : 'Fetch your steps')), //If i have en error dispaly retry // if first fetch for the egg display start
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)),
                          elevation: 10,
                        ),
                      )
                    : Pokeloader(), //if i'm loading display pokeloader
              ),
            ),
          ),
        ),
      ],
    );
  }
}
