import 'package:charging_stations_mobile/models/reservation_slot.dart';

import 'rating.dart';

class ChargingStation {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int tenantId;
  final Rating? ratingDetails;
  final List<ReservationSlot>? reservationSlots;

  ChargingStation(this.id, this.name, this.address, this.latitude, this.longitude, this.tenantId, this.ratingDetails, this.reservationSlots);

  factory ChargingStation.fromJson(Map<String, dynamic> json) {

      Rating? ratingDetails;
      if (json['ratingDetails'] == null){
        ratingDetails = null;
      }
      else{
        ratingDetails = Rating.fromJson(json['ratingDetails']);
      }

      List<ReservationSlot>? reservationSlots;
      if (json['reservationSlots'] == null){
        reservationSlots = null;
      }
      else{
        reservationSlots = List<ReservationSlot>.from(json['reservationSlots'].map((data) => ReservationSlot.fromJson(data)));
      }

      return ChargingStation(
        json['id'],
        json['name'],
        json['address'],
        json['latitude'],
        json['longitude'],
        json['tenantId'],
        ratingDetails,
        reservationSlots
      );
  }
}