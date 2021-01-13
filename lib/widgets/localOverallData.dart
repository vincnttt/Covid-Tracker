import 'package:covid_tracker/services/apiService.dart';
import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';

class LocalOverallData extends StatefulWidget {
  LocalOverallData({
    this.height = 40,
    this.itemCount = 3,
    this.totalForeign,
    this.totalNoSymptom,
    this.totalLeft,
    this.totalConfirm,
    this.totalDeath,
    this.totalHeal
  });

  final double height;
  final int itemCount;
  final String totalForeign;
  final String totalNoSymptom;
  final String totalLeft;
  final String totalConfirm;
  final String totalDeath;
  final String totalHeal;

  @override
  _LocalOverallDataState createState() => _LocalOverallDataState();
}

class _LocalOverallDataState extends State<LocalOverallData> {
  @override
  Widget build(BuildContext context) {
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
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              _rowItem('境外输入', widget.totalForeign,
                  CustomTextStyle.caseForeigner),
              _rowItem('无症状感染者', widget.totalNoSymptom,
                  CustomTextStyle.caseLeft),
              _rowItem('现有确诊', widget.totalLeft,
                CustomTextStyle.caseNow,),
              _rowItem('累计确诊', widget.totalConfirm,
                  CustomTextStyle.totalCase),
              _rowItem('累计死亡', widget.totalDeath,
                  CustomTextStyle.totalDeath),
              _rowItem('累计治愈', widget.totalHeal,
                  CustomTextStyle.totalCured),
            ],
          ),
        )
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

  Widget exceptionCatcher(Widget child) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
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
      child: Center(
        child: Card(
          elevation: 0.0,
          margin: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)
          ),
          child: child,
        ),
      ),
    );
  }

}
