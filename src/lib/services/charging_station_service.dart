import 'dart:convert';
import 'package:charging_stations_mobile/models/charger.dart';
import 'package:charging_stations_mobile/models/charging_station_basic.dart';
import 'package:charging_stations_mobile/models/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charging_stations_mobile/models/charging_station.dart';

import '../config.dart';

class ChargingStationService {
  static Future<List<ChargingStationBasic>> getAsync(double lat, double lng) async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations?lat=' + lat.toString() + '&lng=' + lng.toString()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ChargingStationBasic.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<ChargingStation> getOneAsync(int id, double lat, double lng) async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations/' + id.toString() + '?lat=' + lat.toString() + '&lng=' + lng.toString()));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ChargingStation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<Charger>> getChargersAsync(int chargingStationId) async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations/' + chargingStationId.toString() + '/Chargers'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Charger.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<News>> getNewsAsync() async {
    final response = await http.get(Uri.parse(Config.csUrl + '/News'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => News.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}