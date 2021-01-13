import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:covid_tracker/utils/jsonParser.dart';

Future<CovidData> fetchCovidData() async {
  // 163提供的API接口地址
  final response = await http.get('https://c.m.163.com/ug/api/wuhan/app/data/list-total');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CovidData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}