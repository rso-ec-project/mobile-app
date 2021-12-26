import 'package:charging_stations_mobile/models/comment.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:convert';

class CommentService {
  static Future<List<Comment>> getAsync() async {
    final response = await http.get(Uri.parse(Config.comUrl + '/Comments'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Comment.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}