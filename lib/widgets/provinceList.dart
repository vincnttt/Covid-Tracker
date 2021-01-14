import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:flutter/material.dart';

class ProvinceListData extends StatefulWidget {
  ProvinceListData({
    this.future,
    this.index,
    this.height,
    this.width,
    this.padding,
  });

  final Future future;
  final int index;
  final double height;
  final double width;
  final EdgeInsets padding;

  @override
  _ProvinceListDataState createState() => _ProvinceListDataState();
}

class _ProvinceListDataState extends State<ProvinceListData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: kToolbarHeight * 2.6,
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            color: Colors.transparent,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 34,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {

                int totalLeft = snapshot.data.data.areaTree[2].children[i].total.confirm -
                    snapshot.data.data.areaTree[2].children[i].total.dead -
                    snapshot.data.data.areaTree[2].children[i].total.heal;

                return Container(
                  height: widget.height,
                  width: widget.width,
                  padding: widget.padding,
                  child: Card(
                    elevation: 3,
                    borderOnForeground: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(child: Text('${snapshot.data.data.areaTree[2].children[i].name}', style: CustomTextStyle.provName)),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0.0),
                          childAspectRatio: MediaQuery.of(context).size.height / 400,
                          crossAxisCount: 2,
                          children: <Widget>[
                            boxConstructor('现存确诊',
                                '$totalLeft',
                                CustomTextStyle.provCasesLeft),
                            boxConstructor('累计确诊',
                                '${snapshot.data.data.areaTree[2].children[i].total.confirm}',
                                CustomTextStyle.provTotal),
                            boxConstructor('死亡',
                                '${snapshot.data.data.areaTree[2].children[i].total.dead}',
                                CustomTextStyle.provDeath),
                            boxConstructor('治愈',
                                '${snapshot.data.data.areaTree[2].children[i].total.heal}',
                                CustomTextStyle.provHeal),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
