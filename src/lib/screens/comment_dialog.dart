import 'package:charging_stations_mobile/config.dart';
import 'package:charging_stations_mobile/models/comment.dart';
import 'package:charging_stations_mobile/models/comment_post.dart';
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

  final _commentController = TextEditingController();

  int rating = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chargingStationId = widget.chargingStationId;
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            Text("(${rating.toString()})")
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
                
              },
            )
          ],
        ),
      ],
    );
  }
}
