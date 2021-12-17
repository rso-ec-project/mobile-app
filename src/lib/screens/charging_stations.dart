import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ChargingStationsScreen extends StatefulWidget {
  const ChargingStationsScreen({Key? key}) : super(key: key);

  @override
  _ChargingStationsScreenState createState() => _ChargingStationsScreenState();
}

class _ChargingStationsScreenState extends State<ChargingStationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Charging Stations"),
        ),
        drawer: const AppDrawer(),
        body: const Center(child: Text("Charging Stations")));
  }
}
