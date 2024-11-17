// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      json['batteryPercent'] as String,
      json['functionTimes'] as String,
      json['hotcount'] as String,
      json['hwVersion'] as String,
      json['imei'] as String,
      json['imsi'],
      json['ipAddress'] as String,
      json['issim'] as String,
      json['macAddress'] as String,
      json['networkType'] as String,
      json['networkmask'] as String,
      json['strengthDbm'] as String,
      json['strengthLevel'] as String,
      json['swVersion'] as String,
      json['wifihotname'] as String,
      json['wifisafetype'] as String,
      json['sn'] as String,
      json['dashSinr'] as String,
      json['dashBand'] as String,
      json['dashIccid'] as String,
      json['devVersion'] as String,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'batteryPercent': instance.batteryPercent,
      'functionTimes': instance.functionTimes,
      'hotcount': instance.hotcount,
      'hwVersion': instance.hwVersion,
      'imei': instance.imei,
      'imsi': instance.imsi,
      'ipAddress': instance.ipAddress,
      'issim': instance.issim,
      'macAddress': instance.macAddress,
      'networkType': instance.networkType,
      'networkmask': instance.networkmask,
      'strengthDbm': instance.strengthDbm,
      'strengthLevel': instance.strengthLevel,
      'swVersion': instance.swVersion,
      'wifihotname': instance.wifihotname,
      'wifisafetype': instance.wifisafetype,
      'sn': instance.sn,
      'dashSinr': instance.dashSinr,
      'dashBand': instance.dashBand,
      'dashIccid': instance.dashIccid,
      'devVersion': instance.devVersion,
    };
