import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservations"),
        ),
        drawer: const AppDrawer(),
        body: const Center(child: Text("Reservations")));
  }
}
