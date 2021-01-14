import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:charts_flutter/src/text_element.dart' as element;
// import 'package:charts_flutter/src/text_style.dart' as style;

class GlobalTabPage extends StatefulWidget {
  GlobalTabPage({this.future});

  final Future future;

  @override
  _GlobalTabPageState createState() => _GlobalTabPageState();
}

class _GlobalTabPageState extends State<GlobalTabPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          List<AreaTree> globalData = snapshot.data.data.areaTree;
          List<ChinaDayList> cdl = snapshot.data.data.chinaDayList;

          return Container(
            child: Center(child: Text('暂时无数据！')),
          );
          // return ListView(
          //   shrinkWrap: true,
          //   children: <Widget>[
          //     Center(child: Text('暂时无数据'))
          //   ],
          // );
        } else {
          return Text('计算中...');
        }
      },
    );
  }

  Widget chartTitle(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
      // margin: const EdgeInsets.only(bottom: 6.0),
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
      child: charts.BarChart(
        chartData,
        animate: true,
      ),
    );
  }

}

// class _SelectionCallbackState extends State<GlobalTabPage> {
//   DateTime _time;
//   Map<String, num> _measures;
//
//   // Listens to the underlying selection changes, and updates the information
//   // relevant to building the primitive legend like information under the
//   // chart.
//   _onSelectionChanged(charts.SelectionModel model) {
//     final selectedDatum = model.selectedDatum;
//
//     DateTime time;
//     final measures = <String, num>{};
//
//     // We get the model that updated with a list of [SeriesDatum] which is
//     // simply a pair of series & datum.
//     //
//     // Walk the selection updating the measures map, storing off the sales and
//     // series name for each selection point.
//     if (selectedDatum.isNotEmpty) {
//       time = selectedDatum.first.datum.time;
//       selectedDatum.forEach((charts.SeriesDatum datumPair) {
//         measures[datumPair.series.displayName] = datumPair.datum.sales;
//       });
//     }
//
//     // Request a build.
//     setState(() {
//       _time = time;
//       _measures = measures;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // The children consist of a Chart and Text widgets below to hold the info.
//     final children = <Widget>[
//       new SizedBox(
//           height: 150.0,
//           child: new charts.TimeSeriesChart(
//             widget.seriesList,
//             animate: widget.animate,
//             selectionModels: [
//               new charts.SelectionModelConfig(
//                 type: charts.SelectionModelType.info,
//                 listener: _onSelectionChanged,
//               )
//             ],
//           )),
//     ];
//
//     // If there is a selection, then include the details.
//     if (_time != null) {
//       children.add(new Padding(
//           padding: new EdgeInsets.only(top: 5.0),
//           child: new Text(_time.toString())));
//     }
//     _measures?.forEach((String series, num value) {
//       children.add(new Text('${series}: ${value}'));
//     });
//
//     return new Column(children: children);
//   }
// }

// class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
//   @override
//   void paint(ChartCanvas canvas, Rectangle<num> bounds, {String val, List<int> dashPattern, Color fillColor, FillPatternType fillPattern, Color strokeColor, double strokeWidthPx}) {
//     super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
//     canvas.drawRect(
//         Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
//         fill: Color.white
//     );
//     var textStyle = style.TextStyle();
//     textStyle.color = Color.white;
//     textStyle.fontSize = 15;
//     canvas.drawText(
//         element.TextElement(LocalTabPage.pointerValue, style: textStyle),
//         (bounds.left).round(),
//         (bounds.top - 28).round()
//     );
//   }
// }