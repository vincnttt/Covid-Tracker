import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  TimeDisplay({
    this.time
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Text('截至北京时间 ' + this.time,
        style: CustomTextStyle.time),
    );
  }
}