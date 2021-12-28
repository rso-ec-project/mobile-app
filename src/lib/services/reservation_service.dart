import 'dart:io';
import 'package:charging_stations_mobile/models/reservation.dart';
import 'package:charging_stations_mobile/models/reservation_post.dart';
import 'package:charging_stations_mobile/models/reservation_slot.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:convert';

class ReservationService {

  static HttpClient client = HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) =>
    true);

  static Future<List<ReservationSlot>> getAsync(int chargerId, DateTime from, DateTime to) async {
    var requestString = Config.resUrl + '/ReservationSlots';
    requestString += '?chargerId=' + chargerId.toString();
    requestString += '&from=' + from.toString();
    requestString += '&to=' + to.toString();

    final response = await http.get(Uri.parse(requestString));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ReservationSlot.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<Reservation>> getReservationsAsync(int userId) async {
    var requestString = Config.resUrl + '/Reservations';
    requestString += '?userId=' + userId.toString();

    final response = await http.get(Uri.parse(requestString));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Reservation.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<HttpClientResponse> postAsync(ReservationPost reservationPost) async {
    HttpClientRequest request = await client.postUrl(Uri.parse(Config.resUrl + '/Reservations'));
    request.headers.set('Content-Type', 'application/json');
    print(jsonEncode(reservationPost.toJson()));
    request.write(jsonEncode(reservationPost.toJson()));
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    return response;
  }

  static Future<bool> deleteAsync(int reservationId) async {
    HttpClientRequest request = await client.deleteUrl(Uri.parse(Config.resUrl + '/Reservations/' + reservationId.toString()));
    HttpClientResponse response = await request.close();
    return response.statusCode == 200;
  }

  static Future<List<ReservationSlot>> getEmptyReservationSlotsList() async {
    return <ReservationSlot>[];
  }
}