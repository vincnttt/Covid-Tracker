import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/tools/carouselSlider.dart';
import 'package:flutter/material.dart';

class MainCountryList extends StatefulWidget {
  MainCountryList({
    this.future,
  });

  final Future future;

  @override
  _MainCountryListState createState() => _MainCountryListState();
}

class _MainCountryListState extends State<MainCountryList> {
  int _current = 0; // For current index

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Container(
            child: CarouselSlider(
              height: kToolbarHeight * 3,
              aspectRatio: 3.0,
              autoPlay: false,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: <Widget> [
                // 美国
                cardConstructor(
                    '${snapshot.data.data.areaTree[9].name}',
                    '${snapshot.data.data.areaTree[9].total.confirm -
                        snapshot.data.data.areaTree[9].total.dead -
                        snapshot.data.data.areaTree[9].total.heal}',
                    '${snapshot.data.data.areaTree[9].total.confirm}',
                    '${snapshot.data.data.areaTree[9].total.dead}',
                    '${snapshot.data.data.areaTree[9].total.heal}'
                ),
                // 德国
                cardConstructor(
                    '${snapshot.data.data.areaTree[8].name}',
                    '${snapshot.data.data.areaTree[8].total.confirm -
                        snapshot.data.data.areaTree[8].total.dead -
                        snapshot.data.data.areaTree[8].total.heal}',
                    '${snapshot.data.data.areaTree[8].total.confirm}',
                    '${snapshot.data.data.areaTree[8].total.dead}',
                    '${snapshot.data.data.areaTree[8].total.heal}'
                ),
                // 巴西
                cardConstructor(
                    '${snapshot.data.data.areaTree[71].name}',
                    '${snapshot.data.data.areaTree[71].total.confirm -
                        snapshot.data.data.areaTree[71].total.dead -
                        snapshot.data.data.areaTree[71].total.heal}',
                    '${snapshot.data.data.areaTree[71].total.confirm}',
                    '${snapshot.data.data.areaTree[71].total.dead}',
                    '${snapshot.data.data.areaTree[71].total.heal}'
                ),
                // 法国
                cardConstructor(
                    '${snapshot.data.data.areaTree[157].name}',
                    '${snapshot.data.data.areaTree[157].total.confirm -
                        snapshot.data.data.areaTree[157].total.dead -
                        snapshot.data.data.areaTree[157].total.heal}',
                    '${snapshot.data.data.areaTree[157].total.confirm}',
                    '${snapshot.data.data.areaTree[157].total.dead}',
                    '${snapshot.data.data.areaTree[157].total.heal}'
                ),
                // 俄罗斯
                cardConstructor(
                    '${snapshot.data.data.areaTree[163].name}',
                    '${snapshot.data.data.areaTree[163].total.confirm -
                        snapshot.data.data.areaTree[163].total.dead -
                        snapshot.data.data.areaTree[63].total.heal}',
                    '${snapshot.data.data.areaTree[163].total.confirm}',
                    '${snapshot.data.data.areaTree[163].total.dead}',
                    '${snapshot.data.data.areaTree[163].total.heal}'
                ),
                // 英国
                cardConstructor(
                    '${snapshot.data.data.areaTree[161].name}',
                    '${snapshot.data.data.areaTree[161].total.confirm -
                        snapshot.data.data.areaTree[161].total.dead -
                        snapshot.data.data.areaTree[161].total.heal}',
                    '${snapshot.data.data.areaTree[161].total.confirm}',
                    '${snapshot.data.data.areaTree[161].total.dead}',
                    '${snapshot.data.data.areaTree[161].total.heal}'
                ),
                // 意大利
                cardConstructor(
                    '${snapshot.data.data.areaTree[162].name}',
                    '${snapshot.data.data.areaTree[162].total.confirm -
                        snapshot.data.data.areaTree[162].total.dead -
                        snapshot.data.data.areaTree[162].total.heal}',
                    '${snapshot.data.data.areaTree[162].total.confirm}',
                    '${snapshot.data.data.areaTree[162].total.dead}',
                    '${snapshot.data.data.areaTree[162].total.heal}'
                ),
                // 西班牙
                cardConstructor(
                    '${snapshot.data.data.areaTree[170].name}',
                    '${snapshot.data.data.areaTree[170].total.confirm -
                        snapshot.data.data.areaTree[170].total.dead -
                        snapshot.data.data.areaTree[170].total.heal}',
                    '${snapshot.data.data.areaTree[170].total.confirm}',
                    '${snapshot.data.data.areaTree[170].total.dead}',
                    '${snapshot.data.data.areaTree[170].total.heal}'
                ),
              ]
            ),
          );
        } else if(snapshot.hasError) {
          return Center(child: Text('发现错误，请检查您是否连上互联网'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget cardConstructor(String title, String conf, String left, String dead, String heal) {
    return Card(
      elevation: 1.0,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text(title, style: CustomTextStyle.priorName)),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0.0),
            childAspectRatio: MediaQuery.of(context).size.height / 250,
            crossAxisCount: 2,
            children: <Widget>[
              boxConstructor('现存确诊', left, CustomTextStyle.priorCasesLeft),
              boxConstructor('累计确诊', conf, CustomTextStyle.priorTotal),
              boxConstructor('死亡', dead, CustomTextStyle.priorDeath),
              boxConstructor('治愈', heal, CustomTextStyle.priorHeal),
            ],
          ),
        ],
      ),
    );
  }

  Widget boxConstructor(String title, String total, TextStyle style) {
    return SizedBox.fromSize(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Text(title, style: CustomTextStyle.dataType),
            ),
            Container(
              child: Text(total, style: style),
            ),
          ],
        )
    );
  }
}