import 'package:covid_tracker/pages/about.dart';
import 'package:covid_tracker/pages/dataChartPage.dart';
import 'package:covid_tracker/pages/globalTabPage.dart';
import 'package:covid_tracker/pages/localTabPage.dart';
import 'package:covid_tracker/style/customColor.dart';
import 'package:covid_tracker/tools/pageTransition.dart';
import 'package:covid_tracker/widgets/globalListData.dart';
import 'package:covid_tracker/widgets/globalOverallData.dart';
import 'package:covid_tracker/widgets/mainCountryList.dart';
import 'package:covid_tracker/widgets/provinceList.dart';
import 'package:covid_tracker/widgets/timeDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/widgets/localOverallData.dart';
import 'package:covid_tracker/services/apiService.dart';
import 'package:covid_tracker/utils/jsonParser.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  Future<CovidData> futureCovidData;

  // AnimationController _loadingAC;

  ScrollController _sc;
  bool isCollapsed = false;
  String title = "新型冠状病毒肺炎\n疫情实时播报";

  TabController _tabController;

  /// Dispose multicolor for CircularProgressIndicator
  /// Changed when on load data
  // @override
  // void dispose() {
  //   super.dispose();
  //   _loadingAC.dispose();
  // }

  @override
  void initState() {
    super.initState();
    /// Implement Future data from given API
    futureCovidData = fetchCovidData();

    /// Implement multicolor for CircularProgressIndicator
    // _loadingAC =
    //     AnimationController(duration: Duration(seconds: 2), vsync: this);
    // _loadingAC.repeat();

    /// Title Controller when on scroll
    _sc = ScrollController();

    _sc.addListener(() {
      if (_sc.offset > 100 && !_sc.position.outOfRange) {
        if(!isCollapsed){
          title = "全球新冠肺炎疫情";
          isCollapsed = true;
          setState(() {});
        }
      }
      if (_sc.offset <= 100 && !_sc.position.outOfRange) {
        if(isCollapsed){
          title = "新型冠状病毒肺炎\n疫情实时播报";
          isCollapsed = false;
          setState(() {});
        }
      }
    });

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double titlePadding = screenHeight * 0.02;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return FutureBuilder(
      future: futureCovidData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /// Calculate cases left
          /// Form: confirmed - healed - death = left
          int totalCasesLeft =
              snapshot.data.data.chinaTotal.total.confirm -
                  snapshot.data.data.chinaTotal.total.heal -
                  snapshot.data.data.chinaTotal.total.dead;

          return Scaffold(
            backgroundColor: CustomColor.baseLight,
            body: CustomScrollView(
              controller: _sc,
              slivers: <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  backgroundColor: Colors.deepPurpleAccent,
                  expandedHeight: screenHeight / 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)
                      )
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 24.0, bottom: titlePadding),
                    background: Image.asset('assets/images/appbar_bg.png'),
                    title: Text(title, style: CustomTextStyle.pageTitle),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.show_chart, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(SlideLeftRoute(
                          page: DataChartPage(),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(SlideLeftRoute(
                          page: AboutPage(),
                        ));
                      },
                    )
                  ],
                ),
                SliverPadding(padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0)),
                SliverFillRemaining(
                  hasScrollBody: true,
                  fillOverscroll: false,
                  child: Scaffold(
                    backgroundColor: CustomColor.baseLight,
                    appBar: TabBar(
                      controller: _tabController,
                      unselectedLabelColor: Colors.deepPurpleAccent,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.deepPurpleAccent
                      ),
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.deepPurpleAccent, width: 1)
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("国内疫情数据"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.deepPurpleAccent, width: 1)
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("全球疫情数据"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        /// Mainland China data tab
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            // Display last updated data (UTC+8)
                            TimeDisplay(time: '${snapshot.data.data.lastUpdateTime}'),

                            // Display main cases information in Mainland China
                            LocalOverallData(
                              totalForeign: '${snapshot.data.data.chinaTotal.total.input}',
                              totalNoSymptom: '${snapshot.data.data.chinaTotal.extData.noSymptom}',
                              totalLeft: '$totalCasesLeft',
                              totalConfirm: '${snapshot.data.data.chinaTotal.total.confirm}',
                              totalDeath: '${snapshot.data.data.chinaTotal.total.dead}',
                              totalHeal: '${snapshot.data.data.chinaTotal.total.heal}',
                            ),

                            // Display table data for Mainland China
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, top: 10.0),
                              child: Text('国内疫情表格', style: CustomTextStyle.itemTitle),
                            ),
                            ProvinceListData(
                              future: futureCovidData,
                              height: kToolbarHeight * 2,
                              width: screenWidth / 2.5,
                              padding: EdgeInsets.all(screenHeight * 0.01),
                            ),

                            // CountryGraph(future: futureCovidData),
                          ],
                        ),

                        /// Global data tab
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            // Display last updated data (UTC+8)
                            TimeDisplay(time: '${snapshot.data.data.overseaLastUpdateTime}'),

                            GlobalOverallData(),

                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, top: 10.0),
                              child: Text('重点国家新增确诊趋势表格', style: CustomTextStyle.itemTitle),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                              child: MainCountryList(
                                future: futureCovidData,
                                // height: 200,
                                // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                              child: RaisedButton(
                                color: Colors.deepPurpleAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('查看更多国家', style: CustomTextStyle.btnTitle),
                                    SizedBox(width: 10.0),
                                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(SlideLeftRoute(
                                    page: GlobalListData(
                                      future: futureCovidData,
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent)),
                SizedBox(height: 8.0),
                Center(child: Text('正在加载中...',
                      style: CustomTextStyle.loadDisp)),
              ],
            ),
          );
            // return Center(child: CircularProgressIndicator(
            //   valueColor: _loadingAC
            //       .drive(ColorTween(begin: Colors.deepPurpleAccent, end: Colors.greenAccent)),
            // ));
        }
      },
    );
  }

}