import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'concerts.dart' as concerts;

import '../../globals.dart' as globals;

///////////////////////////////////////
/////////// CONCERT INFO /////////////
/////////////////////////////////////

Future getAllConcerts() async {
  await dotenv.load(fileName: '.env');
  final response = await http.get(
    Uri.parse('${dotenv.env['API_URL'].toString()}/allevents'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': globals.token,
    },
  );
  if (response.statusCode == 200) {
    String receivedJson = response.body;
    List<dynamic> list = json.decode(receivedJson);
    List<concerts.Concert> concertList = [];
    for (var json in list) {
      concerts.Concert concert = concerts.Concert(
        id: json["_id"],
        name: json["name"],
        price: json['price'],
        address: json['address'],
        artist: json["artist"],
        latitude: json['latitude'],
        longitude: json['longitude'],
        image: json['image'],
        date: json['date'],
      );
      concertList.add(concert);
    }
    return concertList;
  } else {
    throw Exception('Failed to get all concerts.');
  }
}
