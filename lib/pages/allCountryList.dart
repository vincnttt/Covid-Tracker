import 'package:covid_tracker/style/customColor.dart';
import 'package:covid_tracker/style/customTextStyle.dart';
import 'package:covid_tracker/utils/jsonParser.dart';
import 'package:flutter/material.dart';

class AllCountryList extends StatefulWidget {
  AllCountryList({
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
  _AllCountryListState createState() => _AllCountryListState();
}

class _AllCountryListState extends State<AllCountryList> {
  TextEditingController _searchController = TextEditingController();

  List<AreaTree> _list = [];
  List<AreaTree> _search = [];
  var loading = false;

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((e) {
      if (e.name.contains(text) ||
          e.name.toString().contains(text)) _search.add(e);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          List<AreaTree> areaTree = snapshot.data.data.areaTree;


          return Scaffold(
            backgroundColor: CustomColor.baseLight,
            appBar: AppBar(
              title: Container(
                height: kToolbarHeight - 12.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '输入国家名称搜索',
                    hintStyle: CustomTextStyle.searchHint,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.cancel, color: Colors.grey),

                      /// When cancel icon pressed, clear TextField
                      onPressed: () => _searchController.clear(),
                    ),
                    border: InputBorder.none,
                  ),
                  style: CustomTextStyle.searchInput,
                  onChanged: (val) {
                    // _filterData(val);
                  },
                ),
              ),
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
                child: _search.length != 0 || _searchController.text.isNotEmpty ? GridView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3/2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0
                  ),
                  itemCount: _search.length,
                  itemBuilder: (context, i) {

                    final res = _search[i];

                    int totalLeft = _search[i].total.confirm -
                        _search[i].total.heal -
                        _search[i].total.dead;

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
                            Container(child: Text(res.name, style: CustomTextStyle.provName)),
                            // Container(child: Text('${snapshot.data.data.areaTree[i].name}', style: CustomTextStyle.provName)),
                            GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(0.0),
                              childAspectRatio: MediaQuery.of(context).size.height / 300,
                              crossAxisCount: 2,
                              children: <Widget>[
                                boxConstructor('现存确诊', '$totalLeft', CustomTextStyle.provCasesLeft),
                                boxConstructor('累计确诊', '${res.total.confirm}', CustomTextStyle.provTotal),
                                boxConstructor('死亡', '${res.total.dead}', CustomTextStyle.provDeath),
                                boxConstructor('治愈', '${res.total.heal}', CustomTextStyle.provHeal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) : Container (

                ),
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
