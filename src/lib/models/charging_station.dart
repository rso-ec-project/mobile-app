import 'rating.dart';

class ChargingStation {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int tenantId;
  final Rating? ratingDetails;

  ChargingStation(this.id, this.name, this.address, this.latitude, this.longitude, this.tenantId, this.ratingDetails);

  factory ChargingStation.fromJson(Map<String, dynamic> json) {

      Rating? ratingDetails;
      if (json['ratingDetails'] == null){
        ratingDetails = null;
      }
      else{
        ratingDetails = Rating.fromJson(json['ratingDetails']);
      }

      return ChargingStation(
        json['id'],
        json['name'],
        json['address'],
        json['latitude'],
        json['longitude'],
        json['tenantId'],
        ratingDetails,
      );
  }
}