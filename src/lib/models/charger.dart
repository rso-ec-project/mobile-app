class Charger {
  final int id;
  final String name;
  final double chargingFeePerKwh;
  final String modelName;
  final String manufacturer;
  final String chargingStationName;
  final String address;

  Charger(this.id, this.name, this.chargingFeePerKwh, this.modelName, this.manufacturer, this.chargingStationName, this.address);

  factory Charger.fromJson(Map<String, dynamic> json) {
    return Charger(
        json['Id'],
        json['Name'],
        json['ChargingFeePerKwh'],
        json['ModelName'],
        json['Manufacturer'],
        json['ChargingStationName'],
        json['Address'],
    );
  }
}