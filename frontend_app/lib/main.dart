// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'screens/home_screens.dart';
import 'screens/login_screens.dart';
import 'screens/register_screens.dart';
import 'screens/preference_screens.dart';
import 'screens/userProfil_screens.dart';
import 'screens/editProfil_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concert Mapper',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginsScreens.routeName,
      routes: {
        HomeScreens.routeName: (context) => const HomeScreens(),
        LoginsScreens.routeName: (context) => const LoginsScreens(),
        RegisterScreens.routeName: (context) => const RegisterScreens(),
        PreferenceScreens.routeName: (context) => const PreferenceScreens(),
        UserProfileScreens.routeName: (context) => const UserProfileScreens(),
        EditProfileScreens.routeName: (context) => const EditProfileScreens(),
      },
    );
  }
}

// class City {
//   final String nom;
//   final String code;

//   const City(this.nom, this.code);
// }

// class ConcertList extends StatefulWidget {
//   const ConcertList({super.key});

//   @override
//   State<ConcertList> createState() => _ConcertListState();
// }

// class _ConcertListState extends State<ConcertList> {
//   late GoogleMapController mapController;

//   final _saved = <String>{};
//   final Map<String, Marker> _markers = {};

//   Future getApiData() async {
//     var response = await http
//         .get(Uri.parse('https://geo.api.gouv.fr/departements/03/communes'));
//     var jsonData = jsonDecode(response.body);
//     List<City> cities = [];
//     for (var c in jsonData) {
//       City city = City(c["nom"], c["code"]);
//       cities.add(city);
//     }
//     return cities;
//   }

//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     final googleOffices = await locations.getGoogleOffices();
//     setState(() {
//       _markers.clear();
//       for (final office in googleOffices.offices) {
//         final marker = Marker(
//           markerId: MarkerId(office.name),
//           position: LatLng(office.lat, office.lng),
//           infoWindow: InfoWindow(
//             title: office.name,
//             snippet: office.address
//           ),
//         );
//         _markers[office.name] = marker;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Concert Mapper'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.list),
//               onPressed: _pushSaved,
//               tooltip: 'Favorite concert',
//             ),
//             IconButton(
//               icon: const Icon(Icons.map_rounded),
//               onPressed: _concertMap,
//               tooltip: 'Concert map',
//             ),
//           ],
//         ),
//         body: Container(
//             child: Card(
//           child: FutureBuilder(
//             future: getApiData(),
//             builder: (context, snapshot) {
//               if (snapshot.data == null) {
//                 return const CircularProgressIndicator();
//               } else
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, i) {
//                       final alreadySaved =
//                           _saved.contains(snapshot.data[i].nom);
//                       return ListTile(
//                         title: Text(snapshot.data[i].nom),
//                         // subtitle: Text(
//                         //   snapshot.data[i].code
//                         // ),
//                         trailing: Icon(
//                           alreadySaved ? Icons.favorite : Icons.favorite_border,
//                           color: alreadySaved ? Colors.red : null,
//                           semanticLabel:
//                               alreadySaved ? 'Remove from saved' : 'Save',
//                         ),
//                         onTap: () {
//                           setState(() {
//                             if (alreadySaved) {
//                               _saved.remove(snapshot.data[i].nom);
//                             } else {
//                               _saved.add(snapshot.data[i].nom);
//                             }
//                           });
//                         },
//                       );
//                     });
//             },
//           ),
//         )));
//   }

//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (context) {
//           final tiles = _saved.map(
//             (pair) {
//               return ListTile(
//                 title: Text(
//                   pair,
//                 ),
//               );
//             },
//           );
//           final divided = tiles.isNotEmpty
//               ? ListTile.divideTiles(
//                   context: context,
//                   tiles: tiles,
//                 ).toList()
//               : <Widget>[];

//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Favorite concert'),
//             ),
//             body: ListView(children: divided),
//           );
//         },
//       ),
//     );
//   }

//   void _concertMap() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Concert map'),
//             ),
//             body: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(46.23, 2.20),
//                 zoom: 6.0,
//               ),
//               markers: _markers.values.toSet(),
//               myLocationEnabled: true,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
