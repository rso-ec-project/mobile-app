import 'dart:convert';

import 'package:charging_stations_mobile/models/ChargingStation.dart';
import 'package:charging_stations_mobile/screens/charging_station_detail.dart';
import 'package:charging_stations_mobile/services/charging_station_service.dart';
import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ChargingStationsScreen extends StatefulWidget {
  const ChargingStationsScreen({Key? key}) : super(key: key);

  @override
  _ChargingStationsScreenState createState() => _ChargingStationsScreenState();
}

class _ChargingStationsScreenState extends State<ChargingStationsScreen> {

  late Future<List<ChargingStation>> futureChargingStations;

  @override
  void initState() {
    super.initState();
    futureChargingStations = ChargingStationService.getAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Charging Stations"),
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
              child: Text('Filters'),
            ),
            Expanded(
              child: FutureBuilder <List<ChargingStation>>(
                future: futureChargingStations,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChargingStation> data = snapshot.data as List<ChargingStation>;
                    return
                      ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var chargingStation = data[index];
                            return ListTile(
                              title: Text(chargingStation.tenantId.toString() + ' ' + chargingStation.name),
                              subtitle: Text(chargingStation.address),
                              isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChargingStationDetailScreen(chargingStationId: chargingStation.id,),
                                  ),
                                );
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
        )
    );
  }
}
