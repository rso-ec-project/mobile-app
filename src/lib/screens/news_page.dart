import 'package:charging_stations_mobile/models/news.dart';
import 'package:charging_stations_mobile/models/tenant.dart';
import 'package:charging_stations_mobile/services/charging_station_service.dart';
import 'package:charging_stations_mobile/services/tenant_service.dart';
import 'package:charging_stations_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = ChargingStationService.getNewsAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News"),
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder <List<News>>(
                future: futureNews,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<News> data = snapshot.data as List<News>;
                    return
                      ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var tenant = data[index];
                            return ListTile(
                              title: Text(tenant.title),
                              subtitle: Text(tenant.source),
                              trailing: const Icon(Icons.open_in_new),
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
