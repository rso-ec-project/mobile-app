import 'package:charging_stations_mobile/screens/charging_stations.dart';
import 'package:charging_stations_mobile/screens/chargers.dart';
import 'package:charging_stations_mobile/screens/tenants.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.ev_station_rounded, text: 'Charging Stations', onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChargingStationsScreen(),
                ),
              ),
          ),
          _createDrawerItem(icon: Icons.business, text: 'Tenants', onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TenantsScreen(),
                ),
              ),
            ),
          ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("ChargingStationsApp",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

