import 'package:charging_stations_mobile/models/tenant.dart';
import 'package:charging_stations_mobile/services/tenant_service.dart';
import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({Key? key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {

  late Future<List<Tenant>> futureTenants;

  @override
  void initState() {
    super.initState();
    futureTenants = TenantService.getAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tenants"),
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder <List<Tenant>>(
                future: futureTenants,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Tenant> data = snapshot.data as List<Tenant>;
                    return
                      ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var tenant = data[index];
                            return ListTile(
                              title: Text(tenant.name),
                              subtitle: Text(tenant.address),
                              isThreeLine: true,
                            );
                          }
                      );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        )
    );
  }
}
