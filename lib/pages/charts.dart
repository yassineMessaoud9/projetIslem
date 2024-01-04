import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testtech/Service/bookService.dart';
import 'package:testtech/models/clickData.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  late Future<ClickData> _futureClickData;
  final BookService bookService = BookService();

  @override
  void initState() {
    super.initState();
    _futureClickData = fetchClickData();
  }

  Future<ClickData> fetchClickData() async {
    var response = await bookService.fetchClickData();
    if (response['success']) {
      // Covert the data to ClickData if the request was successful.
      return ClickData.fromJson(response['data']);
    } else {
      // Throw an exception if there was an error.
      throw Exception(response['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: FutureBuilder<ClickData>(
        future: _futureClickData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final clickData = snapshot.data!;
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Number of Clicked vs Not Clicked Books'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<ClickData, String>>[
                ColumnSeries<ClickData, String>(

                    /// Bind data source
                    dataSource: [clickData],
                    xValueMapper: (ClickData clicks, _) => 'Total Books',
                    yValueMapper: (ClickData clicks, _) => clicks.totalBooks,
                    name: 'Total Books',
                    color: Colors.blue),
                ColumnSeries<ClickData, String>(
                    dataSource: [clickData],
                    xValueMapper: (ClickData clicks, _) => 'Clicked',
                    yValueMapper: (ClickData clicks, _) => clicks.clicked,
                    name: 'Clicked',
                    color: Colors.green),
                ColumnSeries<ClickData, String>(
                    dataSource: [clickData],
                    xValueMapper: (ClickData clicks, _) => 'Not Clicked',
                    yValueMapper: (ClickData clicks, _) => clicks.notClicked,
                    name: 'Not Clicked',
                    color: Colors.red)
              ],
            );
          } else {
            // This should never happen as we expect always to be in one of the above states
            return Center(child: Text('Unexpected state!'));
          }
        },
      ),
    );
  }
}
