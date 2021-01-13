import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:charts_flutter/src/text_style.dart' as style;

class LocalTabPage extends StatefulWidget {
  LocalTabPage({this.future});

  final Future future;
  static String pointerValue;

  @override
  _LocalTabPageState createState() => _LocalTabPageState();
}

class _LocalTabPageState extends State<LocalTabPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          List<ChinaDayList> cdl = snapshot.data.data.chinaDayList;

          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              // 新增确诊
              chartTitle('全国新增确诊'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.today.confirm,
                  colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                )
              ]),

              // 新增境外输入
              chartTitle('全国新增境外输入'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.today.input,
                  colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                )
              ]),

              // 累计境外输入
              chartTitle('全国累计境外输入'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.total.input,
                  colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                )
              ]),

              // 现存确诊
              chartTitle('全国现存确诊'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => (c.total.confirm - c.total.dead - c.total.dead),
                  colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                )
              ]),

              // 累计确诊
              chartTitle('全国累计确诊'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.total.confirm,
                  colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                )
              ]),

              // 累计治愈
              chartTitle('全国累计治愈'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.total.heal,
                  colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                )
              ]),

              // 累计死亡
              chartTitle('全国累计死亡'),
              displayChart([
                charts.Series(
                  id: 'China Mainland',
                  data: cdl,
                  domainFn: (ChinaDayList c, _) => DateTime.parse(c.date),
                  measureFn: (ChinaDayList c, _) => c.total.dead,
                  colorFn: (_, __) => charts.MaterialPalette.black,
                ),
              ]),
            ],
          );
        } else {
          return Text('计算中...');
        }
      },
    );
  }

  Widget chartTitle(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
      child: Text(text, style: CustomTextStyle.itemTitle),
    );
  }

  Widget displayChart(var chartData) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(40 / 2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 40 / 5,
            offset: Offset(0, 40 / 5),
          ),
        ],
      ),
      child: charts.TimeSeriesChart(
        chartData,
        animate: true,
        animationDuration: Duration(milliseconds: 500),
        // behaviors: [
        //   LinePointHighlighter(
        //       symbolRenderer: CircleSymbolRenderer()
        //   )
        // ],
        selectionModels: [
          SelectionModelConfig(
              changedListener: (SelectionModel model) {
                if(model.hasDatumSelection)
                  // val = model.selectedSeries[0].measureFn(model.selectedDatum[0].index).toString();
                  print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
              }
          )
        ],
      ),
    );
  }

}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {String val, List<int> dashPattern, Color fillColor, FillPatternType fillPattern, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
        fill: Color.white
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(
        element.TextElement(LocalTabPage.pointerValue, style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round()
    );
  }
}