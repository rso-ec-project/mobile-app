import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charging_stations_mobile/models/ChargingStation.dart';

import '../config.dart';

class ChargingStationService {
  static Future <List<ChargingStation>> getAsync() async {
    final response = await http.get(Uri.parse(Config.csUrl + '/ChargingStations'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ChargingStation.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}