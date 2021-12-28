import 'package:charging_stations_mobile/models/reservation.dart';
import 'package:charging_stations_mobile/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config.dart';

class UserReservationsScreen extends StatefulWidget {
  const UserReservationsScreen({Key? key}) : super(key: key);

  @override
  _UserReservationsScreenState createState() => _UserReservationsScreenState();
}

class _UserReservationsScreenState extends State<UserReservationsScreen> {

  late Future<List<Reservation>> futureReservations;
  var isSelected = [true, false, false];
  @override
  void initState() {
    super.initState();
    futureReservations = ReservationService.getReservationsAsync(Config.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Reservations"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ToggleButtons(
              children: const <Widget>[
                Text("Verified"),
                Text("Unverified"),
                Text("Closed")
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
          ),
          Expanded(
            child: FutureBuilder <List<Reservation>>(
              future: futureReservations,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Reservation> data = snapshot.data as List<Reservation>;
                  var selectedStatus = isSelected.indexOf(true) + 1;
                  if (selectedStatus == 3) {
                    data = data.where((element) => element.to.compareTo(DateTime.now()) < 0).toList();
                  } else {
                    data = data.where((element) => element.statusId == selectedStatus).toList();
                    data = data.where((element) => element.to.compareTo(DateTime.now()) > 0).toList();
                  }
                  return
                    ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reservation = data[index];
                          return ListTile(
                            title: Text(DateFormat('dd.MM.yyyy HH:mm').format(reservation.from) + ' - ' + DateFormat('HH:mm').format(reservation.to)),
                            subtitle: getSubtitle(reservation),
                            onTap: () {
                              if (selectedStatus < 3){
                                showDialog(
                                    context: context,
                                    builder: (_) => SimpleDialog(
                                      title: const Text("Delete reservation"),
                                      contentPadding: const EdgeInsets.all(30),
                                      children: [
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
                                          child: const Text("Delete", style: TextStyle(color: Colors.white),),
                                          onPressed: () async {
                                            ReservationService.deleteAsync(reservation.id);
                                            setState(() {
                                              futureReservations = ReservationService.getReservationsAsync(Config.userId);
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              );
                            } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Cannot delete a closed reservation."),
                                ));
                              }
                          },
                        );
                      }
                    );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getSubtitle(Reservation reservation) {
    if (reservation.charger == null){
      return const Text("Could not retrieve Charger information");
    } else {
      return Text("${reservation.charger?.chargingStationName}, ${reservation.charger?.address}.   Charger: ${reservation.charger?.name}");
    }
  }
}
