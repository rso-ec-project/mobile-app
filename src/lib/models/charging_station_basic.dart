class ChargingStationBasic {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int tenantId;

  ChargingStationBasic(this.id, this.name, this.address, this.latitude, this.longitude, this.tenantId);

  factory ChargingStationBasic.fromJson(Map<String, dynamic> json) {
        return ChargingStationBasic(
        json['Id'],
        json['Name'],
        json['Address'],
        json['Latitude'],
        json['Longitude'],
        json['TenantId']
    );
  }
}