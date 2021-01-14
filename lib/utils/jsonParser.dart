class CovidData {
  int reqId;
  int code;
  String msg;
  Data data;
  int timestamp;

  CovidData({this.reqId, this.code, this.msg, this.data, this.timestamp});

  CovidData.fromJson(Map<String, dynamic> json) {
    reqId = json['reqId'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reqId'] = this.reqId;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  ChinaTotal chinaTotal;
  List<ChinaDayList> chinaDayList;
  String lastUpdateTime;
  String overseaLastUpdateTime;
  List<AreaTree> areaTree;

  Data({this.chinaTotal, this.chinaDayList, this.lastUpdateTime, this.overseaLastUpdateTime, this.areaTree});

  Data.fromJson(Map<String, dynamic> json) {
    chinaTotal = json['chinaTotal'] != null ? new ChinaTotal.fromJson(json['chinaTotal']) : null;
    if (json['chinaDayList'] != null) {
      chinaDayList = new List<ChinaDayList>();
      json['chinaDayList'].forEach((v) { chinaDayList.add(new ChinaDayList.fromJson(v)); });
    }
    lastUpdateTime = json['lastUpdateTime'];
    overseaLastUpdateTime = json['overseaLastUpdateTime'];
    if (json['areaTree'] != null) {
      areaTree = new List<AreaTree>();
      json['areaTree'].forEach((v) { areaTree.add(new AreaTree.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chinaTotal != null) {
      data['chinaTotal'] = this.chinaTotal.toJson();
    }
    if (this.chinaDayList != null) {
      data['chinaDayList'] = this.chinaDayList.map((v) => v.toJson()).toList();
    }
    data['lastUpdateTime'] = this.lastUpdateTime;
    data['overseaLastUpdateTime'] = this.overseaLastUpdateTime;
    if (this.areaTree != null) {
      data['areaTree'] = this.areaTree.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChinaTotal {
  Today today;
  Total total;
  ExtData extData;

  ChinaTotal({this.today, this.total, this.extData});

  ChinaTotal.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    extData = json['extData'] != null ? new ExtData.fromJson(json['extData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.extData != null) {
      data['extData'] = this.extData.toJson();
    }
    return data;
  }
}

class Today {
  int confirm;
  int suspect;
  int heal;
  int dead;
  int severe;
  int storeConfirm;
  int input;

  Today({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.storeConfirm, this.input});

  Today.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    heal = json['heal'];
    dead = json['dead'];
    severe = json['severe'];
    storeConfirm = json['storeConfirm'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['heal'] = this.heal;
    data['dead'] = this.dead;
    data['severe'] = this.severe;
    data['storeConfirm'] = this.storeConfirm;
    data['input'] = this.input;
    return data;
  }
}

class Total {
  int confirm;
  int suspect;
  int heal;
  int dead;
  int severe;
  int input;

  Total({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.input});

  Total.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    heal = json['heal'];
    dead = json['dead'];
    severe = json['severe'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['heal'] = this.heal;
    data['dead'] = this.dead;
    data['severe'] = this.severe;
    data['input'] = this.input;
    return data;
  }
}

class ExtData {
  int noSymptom;
  int incrNoSymptom;

  ExtData({this.noSymptom, this.incrNoSymptom});

  ExtData.fromJson(Map<String, dynamic> json) {
    noSymptom = json['noSymptom'];
    incrNoSymptom = json['incrNoSymptom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noSymptom'] = this.noSymptom;
    data['incrNoSymptom'] = this.incrNoSymptom;
    return data;
  }
}

class ChinaDayList {
  String date;
  TodayDaily today;
  Total total;
  int extData;
  int lastUpdateTime;

  ChinaDayList({this.date, this.today, this.total, this.extData, this.lastUpdateTime});

  ChinaDayList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    today = json['today'] != null ? new TodayDaily.fromJson(json['today']) : null;
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    extData = json['extData'];
    lastUpdateTime = json['lastUpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    data['extData'] = this.extData;
    data['lastUpdateTime'] = this.lastUpdateTime;
    return data;
  }
}

class TodayDaily {
  int confirm;
  int suspect;
  int heal;
  int dead;
  int severe;
  int storeConfirm;
  int input;

  TodayDaily({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.storeConfirm, this.input});

  TodayDaily.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    heal = json['heal'];
    dead = json['dead'];
    severe = json['severe'];
    storeConfirm = json['storeConfirm'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['heal'] = this.heal;
    data['dead'] = this.dead;
    data['severe'] = this.severe;
    data['storeConfirm'] = this.storeConfirm;
    data['input'] = this.input;
    return data;
  }
}

class AreaTree {
  AreaToday today;
  AreaTotal total;
  AreaExtData extData;
  String name;
  String id;
  String lastUpdateTime;
  List<Children> children;

  AreaTree({this.today, this.total, this.extData, this.name, this.id, this.lastUpdateTime, this.children});

  AreaTree.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new AreaToday.fromJson(json['today']) : null;
    total = json['total'] != null ? new AreaTotal.fromJson(json['total']) : null;
    extData = json['extData'] != null ? new AreaExtData.fromJson(json['extData']) : null;
    name = json['name'];
    id = json['id'];
    lastUpdateTime = json['lastUpdateTime'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) { children.add(new Children.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.extData != null) {
      data['extData'] = this.extData.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    data['lastUpdateTime'] = this.lastUpdateTime;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaToday {
  int confirm;
  int suspect;
  int heal;
  int dead;
  int severe;
  int storeConfirm;
  int input;

  AreaToday({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.storeConfirm, this.input});

  AreaToday.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    heal = json['heal'];
    dead = json['dead'];
    severe = json['severe'];
    storeConfirm = json['storeConfirm'];
    input = json['input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['heal'] = this.heal;
    data['dead'] = this.dead;
    data['severe'] = this.severe;
    data['storeConfirm'] = this.storeConfirm;
    data['input'] = this.input;
    return data;
  }
}

class AreaTotal {
  int confirm;
  int suspect;
  int heal;
  int dead;
  int severe;
  int input;
  int newConfirm;
  int newDead;
  int newHeal;

  AreaTotal({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.input, this.newConfirm, this.newDead, this.newHeal});

  AreaTotal.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    heal = json['heal'];
    dead = json['dead'];
    severe = json['severe'];
    input = json['input'];
    newConfirm = json['newConfirm'];
    newDead = json['newDead'];
    newHeal = json['newHeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['heal'] = this.heal;
    data['dead'] = this.dead;
    data['severe'] = this.severe;
    data['input'] = this.input;
    data['newConfirm'] = this.newConfirm;
    data['newDead'] = this.newDead;
    data['newHeal'] = this.newHeal;
    return data;
  }
}

class AreaExtData {

  AreaExtData();

  AreaExtData.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Children {
  Today today;
  Total total;
  ExtData extData;
  String name;
  String id;
  String lastUpdateTime;
  List<dynamic> children;

  Children({this.today, this.total, this.extData, this.name, this.id, this.lastUpdateTime, this.children});

  Children.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    extData = json['extData'] != null ? new ExtData.fromJson(json['extData']) : null;
    name = json['name'];
    id = json['id'];
    lastUpdateTime = json['lastUpdateTime'];
    children = json['children'];
    // if (json['children'] != null) {
    //   children = new List<Null>();
    //   json['children'].forEach((v) { children.add(new Children.fromJson(v)); });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.extData != null) {
      data['extData'] = this.extData.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    data['lastUpdateTime'] = this.lastUpdateTime;
    data['children'] = this.children;
    // if (this.children != null) {
    //   data['children'] = this.children.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Today {
//   int confirm;
//   int suspect;
//   int heal;
//   int dead;
//   int severe;
//   Null storeConfirm;
//
//   Today({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.storeConfirm});
//
//   Today.fromJson(Map<String, dynamic> json) {
//     confirm = json['confirm'];
//     suspect = json['suspect'];
//     heal = json['heal'];
//     dead = json['dead'];
//     severe = json['severe'];
//     storeConfirm = json['storeConfirm'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['confirm'] = this.confirm;
//     data['suspect'] = this.suspect;
//     data['heal'] = this.heal;
//     data['dead'] = this.dead;
//     data['severe'] = this.severe;
//     data['storeConfirm'] = this.storeConfirm;
//     return data;
//   }
// }
//
// class Total {
//   int confirm;
//   int suspect;
//   int heal;
//   int dead;
//   int severe;
//   int newConfirm;
//   int newDead;
//   int newHeal;
//
//   Total({this.confirm, this.suspect, this.heal, this.dead, this.severe, this.newConfirm, this.newDead, this.newHeal});
//
//   Total.fromJson(Map<String, dynamic> json) {
//     confirm = json['confirm'];
//     suspect = json['suspect'];
//     heal = json['heal'];
//     dead = json['dead'];
//     severe = json['severe'];
//     newConfirm = json['newConfirm'];
//     newDead = json['newDead'];
//     newHeal = json['newHeal'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['confirm'] = this.confirm;
//     data['suspect'] = this.suspect;
//     data['heal'] = this.heal;
//     data['dead'] = this.dead;
//     data['severe'] = this.severe;
//     data['newConfirm'] = this.newConfirm;
//     data['newDead'] = this.newDead;
//     data['newHeal'] = this.newHeal;
//     return data;
//   }
// }