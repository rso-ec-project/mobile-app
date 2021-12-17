class ChargingStation {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int tenantId;

  ChargingStation(this.id, this.name, this.address, this.latitude, this.longitude, this.tenantId);

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
        json['id'],
        json['name'],
        json['address'],
        json['latitude'],
        json['longitude'],
        json['tenantId'],
    );
  }
}