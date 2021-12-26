import 'package:charging_stations_mobile/models/comment.dart';
import 'package:charging_stations_mobile/services/comment_service.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();

  final int chargingStationId;
  final String chargingStationName;

  CommentsScreen({required this.chargingStationId, required this.chargingStationName});
}

class _CommentsScreenState extends State<CommentsScreen> {

  late int chargingStationId;
  late String chargingStationName;
  late Future<List<Comment>> futureComments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chargingStationId = widget.chargingStationId;
    chargingStationName = widget.chargingStationName;
    futureComments = CommentService.getAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chargingStationName),
      ),
      body: FutureBuilder<List<Comment>>(
        future: futureComments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var comments = snapshot.data as List<Comment>;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, i) {
                var comment = comments[i];
                return ListTile(
                  leading: Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber,),
                      Text("x ${comment.rating.toString()}")
                    ],
                  ),
                  title: Text(comment.content),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
