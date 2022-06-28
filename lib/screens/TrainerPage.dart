import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pokesteps/models/LoginPrefs.dart';
import 'package:pokesteps/models/PokeTrainerProvider.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:pokesteps/models/TakeEgg.dart';
import 'package:pokesteps/screens/LoginPage.dart';
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
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            'Pokémon inside the Pokédex',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            child: Consumer<PokeTrainerProvider>(
              builder: (context, value, child) =>
                  Provider.of<PokeTrainerProvider>(context, listen: false)
                              .numberdiscovered ==
                          -1 //-1 numberdisovered: means loading
                      ? Pokeloader()
                      : CircularPercentIndicator(
                          radius: MediaQuery.of(context).size.width * 0.40,
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: Colors.red,
                        ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
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
                      onTap: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        showDialog(
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
                                onPressed: () async {
                                  _toLoginPage(context);
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text('No'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
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
                                  if (await InternetConnectionChecker()
                                          .hasConnection ==
                                      true) {
                                    //delete account only if there's internet connection (required for unauthorize)
                                    Provider.of<StepsCall>(context,
                                                listen: false)
                                            .errorfetchsteps =
                                        false; //reset the button of PokemonPage to fetch if there's an error to no error
                                    await Provider.of<StepsCall>(context,
                                            listen: false)
                                        .clearSumSteps();
                                    await Provider.of<PokeTrainerProvider>(
                                            context,
                                            listen: false)
                                        .deleteallEggData(); //delete all elements in EggTable
                                    await Provider.of<TakeEgg>(context,
                                            listen: false)
                                        .tofalse();
                                    await Provider.of<GeneratePokemon>(context,
                                            listen: false)
                                        .clearIdResponse();
                                    Provider.of<StepsCall>(context,
                                            listen: false)
                                        .unauthorize();
                                    _Delete(
                                        context); //to manage delete account for LoginPage

                                    //print('Deleted all');
                                  } else {
                                    //if not internet connection display snackbar with message for the user
                                    //print('No internet connection');
                                    Navigator.of(context).pop();
                                    final snackbar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .signal_wifi_connected_no_internet_4,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              'No internet connection available')
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(snackbar);
                                  }
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
      ),
    );
  }

  void _toLoginPage(BuildContext context) async {
    Provider.of<LoginPrefs>(context, listen: false).prefs?.setBool('logged',
        false); //so if i close the app i'm redirected to LoginPage even if i have user and password saved
    //Pop the AlertDialog
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacementNamed(LoginPage.route);
  }

  void _Delete(BuildContext context) async {
    Provider.of<LoginPrefs>(context, listen: false)
        .prefs
        ?.setBool('logged', false);
    Provider.of<LoginPrefs>(context, listen: false)
        .prefs
        ?.remove('email'); //remove credentials of user
    Provider.of<LoginPrefs>(context, listen: false).prefs?.remove('password');

    //Pop the AlertDialog
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacementNamed(LoginPage.route);
  }
}
