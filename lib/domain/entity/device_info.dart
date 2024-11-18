import 'package:xtra_pr_71/domain/constants.dart';

class DeviceInfo {
  String batteryPercent;
  String functionTimes;
  int hotcount;
  String hwVersion;
  String imei;
  String imsi;
  String ipAddress;
  bool issim;
  String macAddress;
  String networkType;
  String networkmask;
  String strengthDbm;
  int strengthLevel;
  String swVersion;
  String wifihotname;
  String wifisafetype;
  String sn;
  int dashSinr;
  int dashBand;
  String dashIccid;
  String devVersion;

  DeviceInfo(
      this.batteryPercent,
      this.functionTimes,
      this.hotcount,
      this.hwVersion,
      this.imei,
      this.imsi,
      this.ipAddress,
      this.issim,
      this.macAddress,
      this.networkType,
      this.networkmask,
      this.strengthDbm,
      this.strengthLevel,
      this.swVersion,
      this.wifihotname,
      this.wifisafetype,
      this.sn,
      this.dashSinr,
      this.dashBand,
      this.dashIccid,
      this.devVersion);

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        json['batteryPercent'] ?? cUnknownStr,
        json['functionTimes'] ?? cUnknownStr,
        int.tryParse(json['hotcount']) ?? cUnknownInt,
        json['hwVersion'] ?? cUnknownStr,
        json['imei'] ?? cUnknownStr,
        json['imsi'] ?? cUnknownStr,
        json['ipAddress'] ?? cUnknownStr,
        json['issim'] == cTrueStr,
        json['macAddress'] ?? cUnknownStr,
        json['networkType'] ?? cUnknownStr,
        json['networkmask'] ?? cUnknownStr,
        json['strengthDbm'] ?? cUnknownStr,
        int.tryParse(json['strengthLevel']) ?? cUnknownInt,
        json['swVersion'] ?? cUnknownStr,
        json['wifihotname'] ?? cUnknownStr,
        json['wifisafetype'] ?? cUnknownStr,
        json['sn'] ?? cUnknownStr,
        int.tryParse(json['dashSinr']) ?? cUnknownInt,
        int.tryParse(json['dashBand']) ?? cUnknownInt,
        json['dashIccid'] ?? cUnknownStr,
        json['devVersion'] ?? cUnknownStr,
      );
}
