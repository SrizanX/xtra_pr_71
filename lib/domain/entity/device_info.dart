import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  String batteryPercent;
  String functionTimes;
  String hotcount;
  String hwVersion;
  String imei;
  Object? imsi;
  String ipAddress;
  String issim;
  String macAddress;
  String networkType;
  String networkmask;
  String strengthDbm;
  String strengthLevel;
  String swVersion;
  String wifihotname;
  String wifisafetype;
  String sn;
  String dashSinr;
  String dashBand;
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

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
