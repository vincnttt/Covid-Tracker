import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('关于应用', style: CustomTextStyle.pageTitle),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Container(
            child: Center(
              child: Image.asset('assets/images/app_logo.jpg', width: MediaQuery.of(context).size.width / 4),
            ),
          ),
          SizedBox(height: 18.0),
          Center(
            child: Text(_packageInfo.appName, style: CustomTextStyle.appName),
          ),
          Text('版本 ${_packageInfo.version}', style: CustomTextStyle.appVer),
          SizedBox(height: 20.0),
          Divider(height: 1.0, color: Colors.grey, indent: 24.0, endIndent: 24.0),
          SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
                ),
                children: [
                  TextSpan(text: '本项目的数据接口由于'),
                  TextSpan(
                    text: '网易新闻',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _api163Url(),
                  ),
                  TextSpan(text: '提供的')
                ]
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        height: 1.5
                    ),
                    children: [
                      TextSpan(text: '2020-2021冠状病毒实时播报\n'),
                      TextSpan(text: 'Build with the '),
                      TextSpan(
                        text: 'Flutter SDK',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _flutterUrl(),
                      ),
                    ]
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _flutterUrl() async{
    const url = 'https://flutter.dev/';   // Flutter Official Website
    if(await canLaunch(url)){
      await launch(url);
    } else{
      throw 'Error no page found on $url';
    }
  }

  _api163Url() async{
    const url = 'https://wp.m.163.com/163/page/news/virus_report/index.html?_nw_=1&_anw_=1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error no page found on $url';
    }
  }

}
