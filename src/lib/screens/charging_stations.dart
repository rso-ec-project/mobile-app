import 'package:charging_stations_mobile/models/charging_station_basic.dart';
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

  late Future<List<ChargingStationBasic>> futureChargingStations;

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
            Expanded(
              child: FutureBuilder <List<ChargingStationBasic>>(
                future: futureChargingStations,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChargingStationBasic> data = snapshot.data as List<ChargingStationBasic>;
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
