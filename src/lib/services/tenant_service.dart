import 'dart:convert';
import 'package:charging_stations_mobile/models/Tenant.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class TenantService {
  static Future <List<Tenant>> getAsync() async {
    final response = await http.get(Uri.parse(Config.csUrl + '/Tenants'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Tenant.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}