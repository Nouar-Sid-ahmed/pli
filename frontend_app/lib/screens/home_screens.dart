import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../models/locations.dart' as locations;
import '../models/concerts/concerts.request.dart' as concertRequest;
import 'dart:async';
import '../globals.dart' as globals;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/users/users.request.dart' as userRequest;

import './views/side_menu_view.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);
  static String routeName = '/home-screen';

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final Map<String, Marker> _markers = {};
  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();
  String searchString = "";
  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: '.env');
    userRequest.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.08;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    return MaterialApp(
      home: Scaffold(
        drawer: SideMenu(),
        body: Builder(
          builder: (context) => Stack(
            children: [
              SlidingUpPanel(
                color: const Color.fromRGBO(30, 91, 137, 1),
                maxHeight: panelHeightOpen,
                minHeight: panelHeightClosed,
                parallaxEnabled: true,
                parallaxOffset: .5,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                panelBuilder: (sc) => _panel(sc),
                body: GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(46.23, 2.20),
                    zoom: 6.0,
                  ),
                  mapType: MapType.terrain,
                  myLocationEnabled: true,
                  markers: _markers.values.toSet(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 55, left: 14),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 30, 91, 137),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(Icons.settings, size: 30.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////
  /////////// FUTUR /////////////
  //////////////////////////////

  Future getAllConcerts() async {
    final allConcerts = await concertRequest.getAllConcerts();
    return allConcerts;
  }

  Future<void> _moveToNewLocation(
      double lat, double long, String name, String address) async {
    final _newLocation = LatLng(lat, long);
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(_newLocation, 15));
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(name),
        position: _newLocation,
        infoWindow: InfoWindow(
          title: name,
          snippet: address,
        ),
      );
      _markers[name] = marker;
    });
  }

  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //     final googleOffices = await locations.getGoogleOffices();
  //     setState(() {
  //     _markers.clear();
  //     for (final office in googleOffices.offices) {
  //         final marker = Marker(
  //         markerId: MarkerId(office.name),
  //         position: LatLng(office.lat, office.lng),
  //         infoWindow: InfoWindow(
  //             title: office.name,
  //             snippet: office.address,
  //         ),
  //         );
  //         _markers[office.name] = marker;
  //     }
  //     });
  // }

  /////////////////////////////////
  /////////// WIDGET /////////////
  ///////////////////////////////

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         left: 17, top: 0, right: 17, bottom: 0),
            //     child: TextField(
            //       onChanged: (value) {
            //         setState(() {
            //           searchString = value;
            //         });
            //       },
            //       controller: searchController,
            //       decoration: const InputDecoration(
            //           filled: true,
            //           fillColor: Colors.white,
            //           hintText: "Search",
            //           prefixIcon: Icon(Icons.search),
            //           border: OutlineInputBorder(
            //               borderRadius:
            //                   BorderRadius.all(Radius.circular(25.0)))),
            //     ),
            //   ),
            // ),
            // Container(
            //   child: Padding(
            // margin: const EdgeInsets.only(left: 20, right: 20),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10.0)),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _button("Date", Icons.date_range, Colors.black),
            //     _button("Durée", Icons.access_time_rounded, Colors.black),
            //     _button("Coût", Icons.attach_money_outlined, Colors.black),
            //     _button("Distance", Icons.architecture_sharp, Colors.black),
            //   ],
            // ),
            // ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Concerts",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getAllConcerts(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        snapshot.data[0].name != null
                            ? _concertList(
                                snapshot.data[0].image,
                                snapshot.data[0].name,
                                snapshot.data[0].address,
                                snapshot.data[0].price,
                                snapshot.data[0].date,
                                snapshot.data[0].latitude,
                                snapshot.data[0].longitude)
                            : Container(),
                        const SizedBox(
                          height: 2.0,
                        ),
                        snapshot.data[1].name != null
                            ? _concertList(
                                snapshot.data[1].image,
                                snapshot.data[1].name,
                                snapshot.data[1].address,
                                snapshot.data[1].price,
                                snapshot.data[1].date,
                                snapshot.data[1].latitude,
                                snapshot.data[1].longitude)
                            : Container(),
                        const SizedBox(
                          height: 2.0,
                        ),
                        snapshot.data[2].name != null
                            ? _concertList(
                                snapshot.data[2].image,
                                snapshot.data[2].name,
                                snapshot.data[2].address,
                                snapshot.data[2].price,
                                snapshot.data[2].date,
                                snapshot.data[2].latitude,
                                snapshot.data[2].longitude)
                            : Container(),
                        const SizedBox(
                          height: 2.0,
                        ),
                        snapshot.data[3].name != null
                            ? _concertList(
                                snapshot.data[3].image,
                                snapshot.data[3].name,
                                snapshot.data[3].address,
                                snapshot.data[3].price,
                                snapshot.data[3].date,
                                snapshot.data[3].latitude,
                                snapshot.data[3].longitude)
                            : Container(),
                        const SizedBox(
                          height: 2.0,
                        ),
                        snapshot.data[4].name != null
                            ? _concertList(
                                snapshot.data[4].image,
                                snapshot.data[4].name,
                                snapshot.data[4].address,
                                snapshot.data[4].price,
                                snapshot.data[4].date,
                                snapshot.data[4].latitude,
                                snapshot.data[4].longitude)
                            : Container(),
                        const SizedBox(
                          height: 2.0,
                        ),
                        _navToAllConcertsList(),
                      ],
                    );
                  }
                }),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ));
  }

  Widget _concertList(String concertImage, String concertName,
      String concertAddress, num concertPrice, String concertDate,  double lat, double long) {
    return Card(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  '${dotenv.env['API_URL'].toString()}/$concertImage'),
              radius: 25,
            )
          ],
        ),
        title: Text(
          concertName,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text('$concertAddress\nPrice: $concertPrice € / per\nDate: $concertDate', style: const TextStyle(fontSize: 16)),
        onTap: () {
          _moveToNewLocation(lat, long, concertName, concertAddress);
        },
      ),
    );
  }

  Widget _navToAllConcertsList() {
    return Card(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      color: const Color.fromARGB(255, 228, 228, 228),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: const Text(
          "More concerts",
          style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(85, 136, 185, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "All concerts",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: (15),
                          ),
                          FutureBuilder(
                              future: getAllConcerts(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) => Card(
                                      child: ListTile(
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${dotenv.env['API_URL'].toString()}/${snapshot.data[index].image}'),
                                              radius: 25,
                                            )
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data[index].name,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          '${snapshot.data[index].address}\nPrice: ${snapshot.data[index].price} € / per\nDate: ${snapshot.data[index].date}',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        onTap: () {
                                          _moveToNewLocation(
                                              snapshot.data[index].latitude,
                                              snapshot.data[index].longitude,
                                              snapshot.data[index].name,
                                              snapshot.data[index].address);
                                              
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
        ),
        padding:
            const EdgeInsets.only(top: 20, left: 35, bottom: 20, right: 35),
        child: Icon(icon, color: color),
      ),
    );
  }
}
