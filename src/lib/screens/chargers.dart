import 'package:charging_stations_mobile/models/charger.dart';
import 'package:charging_stations_mobile/screens/reservation_slots.dart';
import 'package:charging_stations_mobile/services/charging_station_service.dart';
import 'package:flutter/material.dart';

class ChargersScreen extends StatefulWidget {

  @override
  _ChargersScreenState createState() => _ChargersScreenState();

  final int chargingStationId;

  ChargersScreen({required this.chargingStationId});
}

class _ChargersScreenState extends State<ChargersScreen> {

  late int chargingStationId;
  late Future<List<Charger>> futureChargers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chargingStationId = widget.chargingStationId;
    futureChargers = ChargingStationService.getChargersAsync(chargingStationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chargers"),
      ),
      body: Column(
        children: [
          Expanded(child:
            FutureBuilder <List<Charger>>(
              future: futureChargers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Charger> data = snapshot.data as List<Charger>;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var charger = data[index];
                        return ListTile(
                          title: Text(charger.name),
                          subtitle: Text(charger.modelName),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationSlotsScreen(chargerId: charger.id,),
                              ),
                            );
                          },
                        );
                      }
                  );
                }
                // By default show a loading spinner.
                return const Expanded(
                    child: Center(child: CircularProgressIndicator())
                );
              }
            )
          )
        ],
      )
    );
  }
}
