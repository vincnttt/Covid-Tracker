import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:covid_tracker/services/apiService.dart';
import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';

class GlobalOverallData extends StatefulWidget {
  GlobalOverallData({
    this.future,
    this.height = 40,
    this.itemCount = 2,
  });

  final Future future;
  final double height;
  final int itemCount;

  @override
  _GlobalOverallDataState createState() => _GlobalOverallDataState();
}

class _GlobalOverallDataState extends State<GlobalOverallData> {

  Future<CovidData> futureCovidData;

  @override
  void initState() {
    super.initState();
    futureCovidData = fetchCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCovidData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // Defining the AreaTree List
          // that providing required data
          List<AreaTree> areaTree = snapshot.data.data.areaTree;

          // Calculate total cases confirmed
          int totalConfirm = 0;
          areaTree.forEach((e) { totalConfirm += e.total.confirm; });

          // Calculate total death cases
          int totalDead = 0;
          areaTree.forEach((e) { totalDead += e.total.dead; });

          // Calculate total healed cases
          int totalHeal = 0;
          areaTree.forEach((e) { totalHeal += e.total.heal; });

          // Calculate total cases left till today
          int totalLeft = totalConfirm - totalDead - totalHeal;

          return Container(
             padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
             margin: EdgeInsets.symmetric(horizontal: 24.0),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(
                   Radius.circular(widget.height / 2)),
               boxShadow: <BoxShadow>[
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.2),
                   blurRadius: widget.height / 5,
                   offset: Offset(0, widget.height / 5),
                 ),
               ],
             ),
             child: Card(
               elevation: 0.0,
               margin: const EdgeInsets.all(0.0),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12.0)
               ),
               child: GridView.count(
                 crossAxisCount: widget.itemCount,
                 padding: const EdgeInsets.all(0.0),
                 childAspectRatio: MediaQuery.of(context).size.height / 400,
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 children: <Widget>[
                   _rowItem('现有确诊', '$totalLeft',
                     CustomTextStyle.caseNow,),
                   _rowItem('累计确诊', '$totalConfirm',
                       CustomTextStyle.totalCase),
                   _rowItem('累计死亡', '$totalDead',
                       CustomTextStyle.totalDeath),
                   _rowItem('累计治愈', '$totalHeal',
                       CustomTextStyle.totalCured),
                 ],
               ),
             )
          );
        } else if(snapshot.hasError) {
          return Center(child: Text('发现错误，请检查您是否连上互联网'));
        } else {
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.greenAccent,
            ),
          );
        }
      },
    );
  }

  Widget _rowItem(String title, String total, TextStyle style) {
    return SizedBox.fromSize(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Text(title, style: CustomTextStyle.caseType),
            ),
            SizedBox(height: 2.0),
            Container(
              /// bool method check whether the API result called successfully or not
              child: Text(total, style: style),
            ),
          ],
        )
    );
  }

}
