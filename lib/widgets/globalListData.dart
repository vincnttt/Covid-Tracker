import 'dart:convert';
import 'package:covid_tracker/style/customColor.dart';
import 'package:http/http.dart' as http;

import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';

class GlobalListData extends StatefulWidget {
  GlobalListData({
    this.future,
    this.height,
    this.width,
    this.margin
  });

  final Future future;
  final double height;
  final double width;
  final EdgeInsets margin;

  @override
  _GlobalListDataState createState() => _GlobalListDataState();
}

class _GlobalListDataState extends State<GlobalListData> {

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
         return Scaffold(
            backgroundColor: CustomColor.baseLight,
            appBar: AppBar(
              title: Text('全球疫情数据', style: CustomTextStyle.pageTitle),
              centerTitle: true,
              // title: Container(
              //   height: kToolbarHeight - 12.0,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(12.0),
              //   ),
              //   alignment: Alignment.center,
              //   child: TextField(
              //     controller: _searchController,
              //     decoration: InputDecoration(
              //       hintText: '输入国家名称搜索',
              //       hintStyle: CustomTextStyle.searchHint,
              //       prefixIcon: Icon(Icons.search, color: Colors.grey),
              //       suffixIcon: IconButton(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         icon: Icon(Icons.cancel, color: Colors.grey),
              //
              //         /// When cancel icon pressed, clear TextField
              //         onPressed: () => _searchController.clear(),
              //       ),
              //       border: InputBorder.none,
              //     ),
              //     style: CustomTextStyle.searchInput,
              //     onChanged: (val) {
              //       // _filterData(val);
              //     },
              //   ),
              // ),
              backgroundColor: Colors.deepPurpleAccent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.transparent,
              child: GridView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3/2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0
                ),
                itemCount: 207,
                itemBuilder: (context, i) {

                  int totalLeft = snapshot.data.data.areaTree[i].total.confirm -
                        snapshot.data.data.areaTree[i].total.heal -
                        snapshot.data.data.areaTree[i].total.dead;

                  return Container(
                    height: widget.height,
                    width: widget.width,
                    margin: widget.margin,
                    child: Card(
                      elevation: 0,
                      borderOnForeground: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(child: Text('${snapshot.data.data.areaTree[i].name}', style: CustomTextStyle.provName)),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0.0),
                            childAspectRatio: MediaQuery.of(context).size.height / 300,
                            crossAxisCount: 2,
                            children: <Widget>[
                              boxConstructor('现存确诊', '$totalLeft', CustomTextStyle.provCasesLeft),
                              boxConstructor('累计确诊', '${snapshot.data.data.areaTree[i].total.confirm}', CustomTextStyle.provTotal),
                              boxConstructor('死亡', '${snapshot.data.data.areaTree[i].total.dead}', CustomTextStyle.provDeath),
                              boxConstructor('治愈', '${snapshot.data.data.areaTree[i].total.heal}', CustomTextStyle.provHeal),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              backgroundColor: Colors.deepPurpleAccent,
              body: Center(child: Text('发现错误，请检查您是否连上互联网',
                  style: TextStyle(color: Colors.white)))
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: Center(child: CircularProgressIndicator(
              backgroundColor: Colors.greenAccent,
            )),
          );
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
