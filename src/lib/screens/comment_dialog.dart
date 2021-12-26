import 'package:charging_stations_mobile/config.dart';
import 'package:charging_stations_mobile/models/comment.dart';
import 'package:charging_stations_mobile/models/comment_post.dart';
import 'package:charging_stations_mobile/models/comment_put.dart';
import 'package:charging_stations_mobile/services/comment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentDialog extends StatefulWidget {

  @override
  _CommentDialogState createState() => _CommentDialogState();

  final int chargingStationId;

  CommentDialog({required this.chargingStationId});
}

class _CommentDialogState extends State<CommentDialog> {

  late int chargingStationId;
  late Future<List<Comment>> futureComments;

  final TextEditingController _commentController = TextEditingController();

  int rating = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chargingStationId = widget.chargingStationId;
    futureComments = CommentService.getAsync(chargingStationId, userId: Config.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: futureComments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var comments = snapshot.data as List<Comment>;

          if (comments.isNotEmpty) {
            return createFullDialog(comments[0]);
          } else {
            return createEmptyDialog();
          }

        } else if (snapshot.hasError) {
          // return Text('${snapshot.error}');
          return createEmptyDialog();
        }

        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget createFullDialog(Comment comment) {

    rating = comment.rating;
    _commentController.text = comment.content;

    return SimpleDialog(
      title: const Text("Comment & Rate"),
      contentPadding: const EdgeInsets.all(30),
      children: [
        TextFormField(
          maxLength: 255,
          initialValue: comment.content,
          decoration: const InputDecoration(
            hintText: 'Comment',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
          ),
          onChanged: (value) => _commentController.text = value,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            RatingBar.builder(
              initialRating: rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemSize: 20,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating.round();
                });
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 10,
          children: <Widget>[
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Update", style: TextStyle(color: Colors.white),),
              onPressed: () {
                var commentPut = CommentPut(_commentController.text, rating);
                CommentService.putAsync(commentPut, comment.id);
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)
              ),
              child: const Text("Delete", style: TextStyle(color: Colors.white),),
              onPressed: () {
                CommentService.deleteAsync(comment.id);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ],
    );
  }

  Widget createEmptyDialog() {
    return SimpleDialog(
      title: const Text("Comment & Rate"),
      contentPadding: const EdgeInsets.all(30),
      children: [
        TextFormField(
          maxLength: 255,
          decoration: const InputDecoration(
            hintText: 'Comment',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
          ),
          onChanged: (value) => _commentController.text = value,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemSize: 20,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating.round();
                });
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 10,
          children: <Widget>[
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Submit", style: TextStyle(color: Colors.white),),
              onPressed: () {
                var commentPost = CommentPost(_commentController.text, rating, Config.userId, chargingStationId);
                print(commentPost.userId);
                print(commentPost.chargingStationId);
                print(commentPost.rating);
                print(commentPost.content);
                CommentService.postAsync(commentPost);
              },
            )
          ],
        ),
      ],
    );
  }
}
