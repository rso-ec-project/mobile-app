import 'dart:convert';
import 'package:charging_stations_mobile/models/charging_station_basic.dart';
import 'package:http/http.dart' as http;
import 'package:charging_stations_mobile/models/charging_station.dart';

import '../config.dart';

class ChargingStationService {
  static Future<List<ChargingStationBasic>> getAsync() async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ChargingStationBasic.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<ChargingStation> getOneAsync(int id) async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations/' + id.toString()));
    if (response.statusCode == 200) {
      return ChargingStation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}