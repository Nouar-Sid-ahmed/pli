import 'package:flutter/material.dart';
import 'home_screens.dart';
import '../globals.dart' as globals;
import '../models/locations.dart' as locations;
import '../models/concerts/concerts.request.dart' as concertRequest;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PreferenceScreens extends StatefulWidget {
  static String routeName = '/preference-screen';

  const PreferenceScreens({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PreferenceScreensState createState() => _PreferenceScreensState();
}

class _PreferenceScreensState extends State<PreferenceScreens> {
  TextEditingController searchController = TextEditingController();
  String searchString = "";

  final _saved = <String>{};

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.of(context).pushNamed(HomeScreens.routeName);
            }),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: _pushSaved,
                tooltip: 'Favorite concert',
              ),
            ],
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: FutureBuilder(
            future: getAllConcerts(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              } else {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 17, top: 0, right: 17, bottom: 0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchString = value;
                          });
                        },
                        controller: searchController,
                        decoration: const InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            String artistToString =
                                snapshot.data[i].artist.toString();
                            String artist = artistToString.substring(
                                1, artistToString.length - 1);
                            final alreadySaved =
                                globals.savedArtistLikes.contains(artist);
                            return snapshot.data[i].name.contains(searchString)
                                ? ListTile(
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${dotenv.env['API_URL'].toString()}/${snapshot.data[i].image}'),
                                          radius: 25,
                                        )
                                      ],
                                    ),
                                    title: Text(
                                      artist,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(snapshot.data[i].name,
                                        style: const TextStyle(fontSize: 16)),
                                    trailing: Icon(
                                      alreadySaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: alreadySaved ? Colors.red : null,
                                      semanticLabel: alreadySaved
                                          ? 'Remove from saved'
                                          : 'Save',
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (alreadySaved) {
                                          globals.savedArtistLikes
                                              .remove(artist);
                                        } else {
                                          globals.savedArtistLikes.add(artist);
                                        }
                                      });
                                    },
                                  )
                                : Container();
                          }),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      // child: Card(
      // child: FutureBuilder(
      //   future: getApiData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.data == null) {
      //       return const CircularProgressIndicator();
      //     } else {
      //       return Column(
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.only(left: 17, top: 50, right: 17, bottom: 0),
      //             child: TextField(
      //               onChanged: (value) {
      //                 setState(() {
      //                   searchString = value;
      //                 });
      //               },
      //               controller: searchController,
      //               decoration: const InputDecoration(
      //                   labelText: "Search",
      //                   hintText: "Search",
      //                   prefixIcon: Icon(Icons.search),
      //                   border: OutlineInputBorder(
      //                       borderRadius:
      //                           BorderRadius.all(Radius.circular(25.0)))),
      //             ),
      //           ),
      //           Expanded(
      //             child: ListView.builder(
      //                 itemCount: snapshot.data.length,
      //                 itemBuilder: (context, i) {
      //                   final alreadySaved = globals.savedArtistLikes.contains(snapshot.data[i].name);
      //                   return snapshot.data[i].name.contains(searchString)
      //                       ? ListTile(
      //                           leading: Column(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             children: <Widget>[
      //                               CircleAvatar(
      //                                 backgroundImage:
      //                                     NetworkImage(snapshot.data[i].image),
      //                                 radius: 25,
      //                               )
      //                             ],
      //                           ),
      //                           title: Text(
      //                             snapshot.data[i].name,
      //                             style: const TextStyle(fontSize: 18),
      //                           ),
      //                           subtitle: Text(snapshot.data[i].address,
      //                               style: const TextStyle(fontSize: 16)),
      //                           trailing: Icon(
      //                             alreadySaved ? Icons.favorite : Icons.favorite_border,
      //                             color: alreadySaved ? Colors.red : null,
      //                             semanticLabel:
      //                             alreadySaved ? 'Remove from saved' : 'Save',
      //                           ),
      //                           onTap: () {
      //                             setState(() {
      //                               if (alreadySaved) {
      //                                 globals.savedArtistLikes.remove(snapshot.data[i].name);
      //                               } else {
      //                                 globals.savedArtistLikes.add(snapshot.data[i].name);
      //                               }
      //                             });
      //                           },
      //                         )
      //                       : Container();
      //                 }),
      //           ),
      //         ],
      //       );
      //     }
      //   },
      // ),
    );
  }

  ////////////////////////////////
  /////////// FUTUR /////////////
  //////////////////////////////

  Future getApiData() async {
    final location = await locations.getGoogleOffices();
    return location.offices;
  }

  Future getAllConcerts() async {
    final allConcerts = await concertRequest.getAllConcerts();
    return allConcerts;
  }

  /////////////////////////////////
  /////////// WIDGET /////////////
  ///////////////////////////////
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = globals.savedArtistLikes.map(
            (artist) {
              return ListTile(
                title: Text(
                  artist,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorite concert'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
