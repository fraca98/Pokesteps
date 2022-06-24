import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokesteps/models/GeneratePokemon.dart';
import 'package:pokesteps/screens/DetailPokemon.dart';
import 'package:pokesteps/widget/pokeloader.dart';
import 'package:provider/provider.dart';
import '../models/PokeTrainerProvider.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  @override
  Widget build(BuildContext context) {
    //print('PokédexPage');
    return Consumer<PokeTrainerProvider>(
      builder: (context, value, child) => Provider.of<PokeTrainerProvider>(
                      context,
                      listen: false)
                  .numberdiscovered ==
              -1 //-1 numberdisovered: means loading so show the loader
          ? Center(child: Pokeloader())
          : Theme(
              //else display the gridview
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.red),
                  crossAxisMargin: 4, //distance from right margin
                ),
              ),
              child: Scrollbar(
                thickness: 10,
                radius: Radius.circular(10),
                interactive: true,
                child: GridView.builder(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  itemCount:
                      Provider.of<GeneratePokemon>(context, listen: false)
                          .numberpk,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var i = Provider.of<PokeTrainerProvider>(context,
                            listen: false)
                        .distinctOpenEggTable
                        ?.map((item) => item
                            .id); //map from the unique opened EggTable the id of the Pokémon
                    //print(i);
                    int idxuniqueEgg =
                        -1; //not found Egg (not discovered) //If i have the Egg i retrieve the index of the corresponding row in EggTable
                    int idxPokemon = -1; //initialize to -1: not found

                    int cnt = 0;
                    for (final element in i!) {
                      cnt = cnt + 1;
                      if (element == index + 1) {
                        idxuniqueEgg = cnt;
                        int cnt_pk = 0;
                        for (final elementPokemon
                            in Provider.of<PokeTrainerProvider>(context,
                                    listen: false)
                                .pokemondatable!) {
                          cnt_pk = cnt_pk + 1;
                          if (elementPokemon.id == element) {
                            idxPokemon = cnt_pk;
                            break;
                          }
                        }
                        break;
                      }
                    }
                    //print('index: $index'); //remember index starts from 0
                    //print('idxunique: $idxuniqueEgg');
                    //print('idxPokemon: $idxPokemon');

                    return InkWell(
                      onTap: () {
                        idxPokemon != -1
                            ? Navigator.pushNamed(context, DetailPokemon.route,
                                arguments: {
                                    'idxPokemon': idxPokemon,
                                    'index': index
                                  })
                            : null;
                      },
                      child: Hero(
                        tag: index,
                        child:  Card(
                            elevation: 3,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.3,
                                  child: idxuniqueEgg != -1
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            'https://raw.githubusercontent.com/fraca98/sprites/master/sprites/pokemon/other/home/${index + 1}.png', //cause index starts from 0
                                        placeholder: (context, url) =>
                                            Pokeloader(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Image.asset('assets/images/missing.png'),),
                                Text('#ID ${index + 1}'),
                                Text(idxuniqueEgg != -1
                                    ? '${toBeginningOfSentenceCase(Provider.of<PokeTrainerProvider>(context, listen: false).pokemondatable![idxPokemon - 1].name)}'
                                    : '???'), //-1 cause table index is from 0
                              ],
                            ),
                          ),
                        ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
