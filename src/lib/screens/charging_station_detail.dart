import 'package:charging_stations_mobile/models/ChargingStation.dart';
import 'package:charging_stations_mobile/services/charging_station_service.dart';
import 'package:flutter/material.dart';

class ChargingStationDetailScreen extends StatefulWidget {
  @override
  _ChargingStationDetailScreenState createState() => _ChargingStationDetailScreenState();

  final int chargingStationId;

  ChargingStationDetailScreen({required this.chargingStationId});
}

class _ChargingStationDetailScreenState extends State<ChargingStationDetailScreen> {

  late int chargingStationId;
  late Future<ChargingStation> futureChargingStation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chargingStationId = widget.chargingStationId;
    futureChargingStation = ChargingStationService.getOneAsync(chargingStationId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChargingStation>(
      future: futureChargingStation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var chargingStation = snapshot.data as ChargingStation;
          return Scaffold(
            appBar: AppBar(
              title: Text(chargingStation.name),
            ),
            body: Center(
              child: Column(
                children: [
                  Text(chargingStation.tenantId.toString()),
                  Text(chargingStation.address),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(chargingStationId.toString()),
      ),
    );
  }
}
