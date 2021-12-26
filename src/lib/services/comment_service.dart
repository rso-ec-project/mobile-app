import 'dart:io';

import 'package:charging_stations_mobile/models/comment.dart';
import 'package:charging_stations_mobile/models/comment_post.dart';
import 'package:charging_stations_mobile/models/comment_put.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:convert';

class CommentService {

  static HttpClient client = HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) =>
    true);

  static Future<List<Comment>> getAsync(int chargingStationId, {int? userId}) async {
    var requestString = Config.comUrl + '/Comments?chargingStationId=' + chargingStationId.toString();
    if (userId != null){
      requestString += '&userId=' + userId.toString();
    }
    final response = await http.get(Uri.parse(requestString));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Comment.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<Comment> postAsync(CommentPost commentPost) async {
    HttpClientRequest request = await client.postUrl(Uri.parse(Config.comUrl + '/Comments'));
    request.headers.set('Content-Type', 'application/json');
    request.write(jsonEncode(commentPost.toJson()));
    HttpClientResponse response = await request.close();
    String contents = await response.transform(utf8.decoder).join();
    return Comment.fromJson(json.decode(contents));
  }

  static Future<Comment> putAsync(CommentPut commentPut, int commentId) async {
    HttpClientRequest request = await client.putUrl(Uri.parse(Config.comUrl + '/Comments/' + commentId.toString()));
    request.headers.set('Content-Type', 'application/json');
    request.write(jsonEncode(commentPut.toJson()));
    HttpClientResponse response = await request.close();
    String contents = await response.transform(utf8.decoder).join();
    return Comment.fromJson(json.decode(contents));
  }

  static Future<bool> deleteAsync(int commentId) async {
    HttpClientRequest request = await client.deleteUrl(Uri.parse(Config.comUrl + '/Comments/' + commentId.toString()));
    HttpClientResponse response = await request.close();
    return response.statusCode == 200;
  }
}