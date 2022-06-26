import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'package:pokesteps/models/entities/Detail.dart';
import 'package:pokesteps/models/PokeTrainerProvider.dart';
import 'package:provider/provider.dart';

import '../widget/pokeloader.dart';

class DetailPokemon extends StatefulWidget {
  const DetailPokemon({Key? key}) : super(key: key);

  static const route = '/detailpokemon/';
  static const routename = 'Detailpokemon';

  @override
  State<DetailPokemon> createState() => _DetailPokemonState();
}

class _DetailPokemonState extends State<DetailPokemon> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments! as Map;
    //print(args);
    final int idxPokemon = args['idxPokemon'];
    final int index = args['index'];
    //print(idxPokemon);
    //print(index);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
            '${toBeginningOfSentenceCase(Provider.of<PokeTrainerProvider>(context, listen: false).pokemondatable![idxPokemon - 1].name)}'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white, //Set background color of scaffold to white
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: index,
            child: Container(
              height: MediaQuery.of(context).size.height*0.4,
              child: CachedNetworkImage(
                imageUrl:
                    'https://raw.githubusercontent.com/fraca98/sprites/master/sprites/pokemon/other/home/${Provider.of<PokeTrainerProvider>(context, listen: false).pokemondatable![idxPokemon - 1].id}.png',
                placeholder: (context, url) => Pokeloader(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(),
          Expanded(
            //expand container till the end of the page
            child: Container(
              child: FutureBuilder(
                future: Apicalls().detailApi(
                    Provider.of<PokeTrainerProvider>(context, listen: false)
                        .pokemondatable![idxPokemon - 1]
                        .id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final det = snapshot.data as Detail;
                    //print('det: $det');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DataTable(
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  '#ID',
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  '${det.id}',
                                  style: TextStyle(fontSize: 20),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  'Height',
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  '${(det.height * 0.1).toStringAsFixed(2)} m',
                                  style: TextStyle(fontSize: 20),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  'Weight',
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  '${(det.weight * 0.1).toStringAsFixed(2)} kg',
                                  style: TextStyle(fontSize: 20),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  'Steps to hatch the egg',
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  '${(Provider.of<PokeTrainerProvider>(context, listen: false).pokemondatable![idxPokemon - 1].hatchcounter + 1)*255} ',
                                  style: TextStyle(fontSize: 20),
                                )),
                              ],
                            ),
                          ],
                          columns: [
                            DataColumn(
                                label: Text(
                              'Details',
                              style: TextStyle(fontSize: 20),
                            )),
                            DataColumn(label: Container()),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Pokeloader();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
