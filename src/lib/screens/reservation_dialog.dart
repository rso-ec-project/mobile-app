import 'package:charging_stations_mobile/models/reservation_post.dart';
import 'package:charging_stations_mobile/models/reservation_slot.dart';
import 'package:charging_stations_mobile/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';

import '../config.dart';

class ReservationDialog extends StatefulWidget {

  @override
  _ReservationDialogState createState() => _ReservationDialogState();

  final ReservationSlot reservationSlot;

  ReservationDialog({required this.reservationSlot});
}

class _ReservationDialogState extends State<ReservationDialog> {

  late ReservationSlot reservationSlot;
  // late Future<List<Comment>> futureComments;
  late DateTime startTime;
  late DateTime endTime;
  int duration = 15;
  int maxDuration = 120;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reservationSlot = widget.reservationSlot;
    startTime = reservationSlot.from;
    endTime = reservationSlot.to;

    var diff = endTime.difference(startTime).inMinutes;
    duration = diff;
    if (diff > 120) {
      duration = 120;
    }
    endTime = startTime.add(Duration(minutes: duration));

    maxDuration = duration;

    // futureComments = CommentService.getAsync(chargingStationId, userId: Config.userId);
  }

  @override
  Widget build(BuildContext context) {
    return createFullDialog(reservationSlot);
  }

  Widget createFullDialog(ReservationSlot reservationSlot) {
    return SimpleDialog(
      title: const Text("Reservation"),
      contentPadding: const EdgeInsets.all(30),
      children: [
        const Text("From:", style: TextStyle(fontSize: 16),),
        Wrap(
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(DateFormat('dd.MM.yyyy hh:mm').format(startTime), style: const TextStyle(fontSize: 18),),
            InkResponse(
                child: const Icon(Icons.edit, color: Colors.blue,),
                onTap: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: startTime,
                      maxTime: reservationSlot.to,
                      onChanged: (date) {
                        print('change $date');
                      },
                      onConfirm: (date) {
                        setState(() {
                          startTime = date;
                          var diff = reservationSlot.to.difference(startTime).inMinutes;
                          duration = diff;
                          if (diff > 120) {
                            duration = 120;
                          }
                          endTime = startTime.add(Duration(minutes: duration));

                          maxDuration = duration;
                        });
                      },
                      currentTime: startTime, locale: LocaleType.si);
                }
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Duration:', style: TextStyle(fontSize: 16),),
        NumberPicker(
          value: duration,
          minValue: 15,
          maxValue: maxDuration,
          onChanged: (value) {
            setState(() {
              duration = value;
              endTime = startTime.add(Duration(minutes: duration));
            });
          },
          axis: Axis.horizontal,
          step: 5,
          itemHeight: 50,
        ),
        const Text("To:", style: TextStyle(fontSize: 16),),
        Text(DateFormat('dd.MM.yyyy hh:mm').format(endTime), style: const TextStyle(fontSize: 18),),
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
              onPressed: () async {
                var response = await ReservationService.postAsync(ReservationPost(startTime, endTime, Config.userId, reservationSlot.chargerId));

                if (response.statusCode == 409){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Posted reservation is overlapping with an existing reservation."),
                  ));
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
