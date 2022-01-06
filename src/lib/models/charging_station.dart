import 'package:charging_stations_mobile/models/reservation_slot.dart';

import 'rating.dart';

class ChargingStation {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double? distance;
  final int tenantId;
  final Rating? ratingDetails;
  final List<ReservationSlot>? reservationSlots;

  ChargingStation(this.id, this.name, this.address, this.latitude, this.longitude, this.distance, this.tenantId, this.ratingDetails, this.reservationSlots);

  factory ChargingStation.fromJson(Map<String, dynamic> json) {

      Rating? ratingDetails;
      if (json['RatingDetails'] == null){
        ratingDetails = null;
      }
      else{
        ratingDetails = Rating.fromJson(json['RatingDetails']);
      }

      List<ReservationSlot>? reservationSlots;
      if (json['ReservationSlots'] == null){
        reservationSlots = null;
      }
      else{
        reservationSlots = List<ReservationSlot>.from(json['ReservationSlots'].map((data) => ReservationSlot.fromJson(data)));
      }

      return ChargingStation(
        json['Id'],
        json['Name'],
        json['Address'],
        json['Latitude'],
        json['Longitude'],
        json['DistanceFromLocation'],
        json['TenantId'],
        ratingDetails,
        reservationSlots
      );
  }
}