import 'package:charging_stations_mobile/models/reservation_slot.dart';
import 'package:charging_stations_mobile/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationSlotsScreen extends StatefulWidget {

  @override
  _ReservationSlotsScreenState createState() => _ReservationSlotsScreenState();

  final int chargerId;

  ReservationSlotsScreen({required this.chargerId});
}

class _ReservationSlotsScreenState extends State<ReservationSlotsScreen> {
  late Future<List<ReservationSlot>> futureReservationSlots;
  var selectedDate = DateTime.now();
  var from = DateTime.now();
  var to = DateTime.now().add(const Duration(days: 4));
  var reservationSlots = [];

  late int chargerId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dateTimeTo = DateTime(to.year, to.month, to.day, 23, 59, 0);
    chargerId = widget.chargerId;
    futureReservationSlots = ReservationService.getAsync(chargerId, from, dateTimeTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation Slots"),
      ),
        body: Column(
          children: [
            Row(
              children: createButtonsForTheNext5Days(),
            ),
            Expanded(
              child: FutureBuilder<List<ReservationSlot>>(
                future: futureReservationSlots,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Reservations are currently unavailable."),
                    );
                  }
                  if (snapshot.hasData) {
                    var reservationSlots = snapshot.data as List<ReservationSlot>;
                    reservationSlots = reservationSlots.where((x) => isEqualToSelected(x.from)).toList();
                    return ListView.builder(
                      itemCount: reservationSlots.length,
                      itemBuilder: (context, i) {
                        var reservationSlot = reservationSlots[i];
                        var from = "${reservationSlot.from.hour.toString().padLeft(2, '0')}:${reservationSlot.from.minute.toString().padRight(2, '0')}";
                        var to = "${reservationSlot.to.hour.toString().padLeft(2, '0')}:${reservationSlot.to.minute.toString().padRight(2, '0')}";

                        var range = "$from - $to";

                        if (!isEqualToSelected(reservationSlot.to)) {
                          range += ' (${DateFormat('EEE').format(reservationSlot.to)})';
                        }

                        return ListTile(
                          leading: const Icon(Icons.electrical_services),
                          title: Text(range),
                          subtitle: Text(reservationSlot.chargerName),
                        );
                      },
                    );
                  }

                  // By default, show a loading spinner.
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            )
          ],
        )
    );
  }

  List<Widget> createButtonsForTheNext5Days() {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day, 0, 0, 0);

    var dates = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
      today.add(const Duration(days: 3)),
      today.add(const Duration(days: 4)),
    ];

    List<Widget> buttons = <Widget>[];
    for (var i = 0; i < 5; i++) {
      var date = dates[i];
      buttons.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(isEqualToSelected(date) ? Colors.blue : Colors.blueGrey),
              ),
              child: Column(
                children: [
                  Text(DateFormat('EEE').format(date)),
                  Text("${date.day}.${date.month}"),
                ],
              ),
              onPressed: () {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  bool isEqualToSelected(DateTime dateTime){
    return dateTime.day == selectedDate.day && dateTime.month == selectedDate.month && dateTime.year == selectedDate.year;
  }
}
