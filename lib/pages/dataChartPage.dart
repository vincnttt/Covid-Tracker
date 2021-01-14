import 'package:covid_tracker/pages/globalTabPage.dart';
import 'package:covid_tracker/pages/localChartStatsPage.dart';
import 'package:covid_tracker/pages/localTabPage.dart';
import 'package:covid_tracker/services/apiService.dart';
import 'package:covid_tracker/style/customColor.dart';
import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';

class DataChartPage extends StatefulWidget {
  @override
  _DataChartPageState createState() => _DataChartPageState();
}

class _DataChartPageState extends State<DataChartPage> with SingleTickerProviderStateMixin {

  Future<CovidData> futureCovidData;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    futureCovidData = fetchCovidData();

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.baseLight,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey[200],
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            Tab(text: '国内疫情趋势'),
            Tab(text: '全球疫情趋势'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: futureCovidData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return TabBarView(
              controller: _tabController,
              children: <Widget>[
                LocalChartStatsPage(future: futureCovidData),
                GlobalTabPage(future: futureCovidData)
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('发现错误，请检查您是否连上互联网',
                style: TextStyle(color: Colors.white))
            );
          } else {
            return Center(child: CircularProgressIndicator(
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
        },
      )
    );
  }
}
