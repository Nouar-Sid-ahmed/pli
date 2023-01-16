import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../globals.dart' as globals;

///////////////////////////////////////
/////////// CONCERT INFO /////////////
/////////////////////////////////////

@JsonSerializable()
class Concert {
  const Concert({
    required this.id,
    required this.name,
    required this.price,
    required this.address,
    required this.artist,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.date,
  });

  final String id;
  final String name;
  final num price;
  final String address;
  final List artist;
  final double latitude;
  final double longitude;
  final String image;
  final String date;
}