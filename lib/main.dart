/*
* Author: Vincent Lin
* Date: 2020.12.18
* */

import 'package:covid_tracker/pages/mainPage.dart';
import 'package:covid_tracker/utils/overglowBehavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return MaterialApp(
      title: '全球新冠肺炎疫情',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,

        splashColor: Colors.transparent,
      ),
      builder: (context, child){
        return ScrollConfiguration(
          behavior: OverGlowBehavior(),
          child: child,
        );
      },
      home: MainPage(),
    );
  }
}