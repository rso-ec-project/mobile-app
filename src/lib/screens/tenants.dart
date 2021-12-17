import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({Key? key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tenants"),
        ),
        drawer: const AppDrawer(),
        body: const Center(child: Text("Tenants")));
  }
}
