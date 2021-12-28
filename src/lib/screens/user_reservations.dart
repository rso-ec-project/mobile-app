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
          Expanded(
            child: FutureBuilder <List<Reservation>>(
              future: futureReservations,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Reservation> data = snapshot.data as List<Reservation>;
                  return
                    ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reservation = data[index];
                          return ListTile(
                            title: Text(DateFormat('dd.MM.yyyy hh:mm').format(reservation.from)),
                            onTap: () {

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
}
