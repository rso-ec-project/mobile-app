class Tenant {
  final int id;
  final String name;
  final String address;

  Tenant(this.id, this.name, this.address);

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      json['id'],
      json['name'],
      json['address'],
    );
  }
}