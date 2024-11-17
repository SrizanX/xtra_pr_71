class WirelessInfo {
  String wifiName;
  String password;
  int bandtype;
  int iswifihot;
  int maxnum;
  int wifitype;
  bool isHide;
  bool isClose;

  WirelessInfo.fromJson(Map<String, dynamic> json)
      : wifiName = json['m__ip'],
        password = json['mac__address'],
        bandtype = int.parse(json['bandtype']),
        iswifihot = int.parse(json['iswifihot']),
        maxnum = int.parse(json['maxnum']),
        wifitype = int.parse(json['wifitype']),
        isHide = json['isHide'] == 'true',
        isClose = json['isClose'] == 'true';
}
