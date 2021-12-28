import 'dart:convert';
import 'package:charging_stations_mobile/models/charger.dart';
import 'package:charging_stations_mobile/models/charging_station_basic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charging_stations_mobile/models/charging_station.dart';

import '../config.dart';

class ChargingStationService {
  static Future<List<ChargingStationBasic>> getAsync() async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ChargingStationBasic.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<ChargingStation> getOneAsync(int id) async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations/' + id.toString()));
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
}