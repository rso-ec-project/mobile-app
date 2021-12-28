import 'package:charging_stations_mobile/models/charger.dart';
import 'package:charging_stations_mobile/models/charging_station.dart';
import 'package:charging_stations_mobile/models/rating.dart';
import 'package:charging_stations_mobile/models/reservation_slot.dart';
import 'package:charging_stations_mobile/screens/comment_dialog.dart';
import 'package:charging_stations_mobile/screens/comments.dart';
import 'package:charging_stations_mobile/screens/chargers.dart';
import 'package:charging_stations_mobile/screens/reservation_dialog.dart';
import 'package:charging_stations_mobile/services/charging_station_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                  ListTile(
                      leading: const Icon(Icons.location_on_sharp, color: Colors.red,),
                      title: Text(chargingStation.address),
                      trailing: Wrap(
                        spacing: 20,
                        children: [
                          InkResponse(
                            child: const Text("See on map", style: TextStyle(color: Colors.blue),),
                            onTap: () {},
                          ),
                        ],
                      )
                  ),
                  ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber,),
                      title: const Text("Ratings"),
                      trailing: Wrap(
                        spacing: 20,
                        children: [
                          InkResponse(
                            child: const Text("Rate", style: TextStyle(color: Colors.blue),),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => CommentDialog(chargingStationId: chargingStationId)
                              );
                            },
                          ),
                          InkResponse(
                            child: const Text("View comments", style: TextStyle(color: Colors.blue),),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentsScreen(chargingStationId: chargingStation.id, chargingStationName: chargingStation.name,),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                  ),
                  createRatingsSection(chargingStation),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.ev_station, color: Colors.black,),
                          title: const Text("Quick Reservation"),
                          trailing: InkResponse(
                            child: const Text("View all chargers", style: TextStyle(color: Colors.blue),),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChargersScreen(chargingStationId: chargingStation.id),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          child: createQuickReservationList(chargingStation),
                        )
                      ],
                    ),
                  ),
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

  Widget createRatingBar(double rating) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemSize: 17,
      itemCount: 5,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 5,
      ),
      onRatingUpdate: (value) {},
      ignoreGestures: true,
    );
  }

  Widget createRatingDetail(String ratingName, int ratingCount, int totalCount){

    double percentage;
    String percentageString;
    if (totalCount == 0){
      percentage = 0.0;
      percentageString = '0';
    }
    else{
      percentage = ratingCount / totalCount;
      percentageString = (percentage * 100).toStringAsFixed(1);
    }

    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(ratingName + ': '),
        SizedBox(
          width: 125,
          child: LinearProgressIndicator(
            value: percentage,
          ),
        ),
        Text(percentageString + '%'),
      ],
    );
  }

  Widget createRatingsSection(ChargingStation chargingStation){

    if (chargingStation.ratingDetails == null) {
      return const Text("Ratings are currently unavailable");
    }
    var details = chargingStation.ratingDetails as Rating;
    return Column(
      children: [
        Wrap(
          spacing: 5,
          children: [
            const Text('Avg. rating: '),
            createRatingBar(details.rating),
            Text(details.rating.toString()),
            Text('(' + details.totalRatingCount.toString() + ')')
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        createRatingDetail('1', details.rating1Count, details.totalRatingCount),
        createRatingDetail('2', details.rating2Count, details.totalRatingCount),
        createRatingDetail('3', details.rating3Count, details.totalRatingCount),
        createRatingDetail('4', details.rating4Count, details.totalRatingCount),
        createRatingDetail('5', details.rating5Count, details.totalRatingCount),
      ],
    );
  }

  Widget createQuickReservationList(ChargingStation chargingStation){
    if (chargingStation.reservationSlots != null){
      var reservationSlots = chargingStation.reservationSlots as List<ReservationSlot>;
      return Expanded(
          child: ListView.builder(
            itemCount: reservationSlots.length,
            itemBuilder: (context, i) {
              var reservationSlot = reservationSlots[i];
              var day = "${reservationSlot.from.day.toString()}.${reservationSlot.from.month.toString()}.${reservationSlot.from.year.toString()}";
              var from = "${reservationSlot.from.hour.toString().padLeft(2, '0')}:${reservationSlot.from.minute.toString().padRight(2, '0')}";
              var to = "${reservationSlot.to.hour.toString().padLeft(2, '0')}:${reservationSlot.to.minute.toString().padRight(2, '0')}";

              return ListTile(
                leading: const Icon(Icons.electrical_services),
                title: Text("$day, $from - $to"),
                subtitle: Text(reservationSlot.chargerName),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => ReservationDialog(reservationSlot: reservationSlot)
                  );
                },
              );
            },
        )
      );
    }
    else{
      return const Text("Reservations are currently unavailable");
    }
  }
}
