import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pokesteps/models/PokeTrainerProvider.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:pokesteps/models/TakeEgg.dart';
import 'package:pokesteps/widget/pokeloader.dart';
import 'package:provider/provider.dart';

import '../models/GeneratePokemon.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  @override
  Widget build(BuildContext context) {
    //print('Trainer');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 45,
        ),
        Text('Pokémon inside the Pokédex',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 260,
          child: Center(
            child: Consumer<PokeTrainerProvider>(
              builder: (context, value, child) =>
                  Provider.of<PokeTrainerProvider>(context, listen: false)
                              .numberdiscovered ==
                          -1 //-1 numberdisovered: means loading
                      ? Pokeloader()
                      : CircularPercentIndicator(
                          radius: 130.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 30.0,
                          percent: Provider.of<PokeTrainerProvider>(context,
                                      listen: false)
                                  .numberdiscovered /
                              Provider.of<GeneratePokemon>(context,
                                      listen: false)
                                  .numberpk,
                          center: Text(
                            "${Provider.of<PokeTrainerProvider>(context, listen: false).numberdiscovered}/${Provider.of<GeneratePokemon>(context, listen: false).numberpk} ",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: Colors.red,
                        ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 300,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    tileColor: Colors.yellow.withOpacity(0.5),
                    title: Text('Logout'),
                    trailing: Icon(Icons.logout),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout',
                            ),
                          ],
                        ),
                        content: Text(
                          'Are you sure to logout?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _toLoginPage(context);
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    tileColor: Colors.red.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text('Delete account & Unauthorize'),
                    trailing: Icon(Icons.delete_forever),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Warning',
                            ),
                          ],
                        ),
                        content: Text(
                          'Are you sure to unauthorize the app and delete all your data?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Provider.of<StepsCall>(context, listen: false)
                                        .errorfetchsteps =
                                    false; //reset che button of PokemonPage to fetch oif there's an error to no error now
                                await Provider.of<StepsCall>(context,
                                        listen: false)
                                    .clearSumSteps();
                                await Provider.of<PokeTrainerProvider>(context,
                                        listen: false)
                                    .deleteallEggData();
                                Provider.of<TakeEgg>(context, listen: false)
                                    .tofalse();

                                //Here unauthorize
                                Provider.of<StepsCall>(context, listen: false)
                                    .unauthorize();

                                _Delete(context);
                                print('Deleted all');
                              },
                              child: Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'))
                        ],
                        elevation: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _toLoginPage(BuildContext context) async {
    //Pop the Alert diaogue first
    Navigator.pop(context);
  }

  void _Delete(BuildContext context) async {
    //Pop the Alert diaogue first
    Navigator.pop(context);
  }
}
