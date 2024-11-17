import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/presentation/home/dashboard/dashboard_item.dart';
import 'package:xtra_pr_71/presentation/home/dashboard/dashboard_item_card.dart';
import 'package:xtra_pr_71/presentation/home/dashboard/signal_strength_indicator_widget.dart';

import 'battery_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: _fetchDashboardData(),
          builder: (BuildContext context, AsyncSnapshot<DeviceInfo> snapshot) {
            if (snapshot.hasData) {
              return buildDashboardUi(snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildDashboardUi(DeviceInfo info) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            VerticalBatteryIndicator(percentage: info.batteryPercent),
            const SizedBox(width: 24),
            SignalStrengthIndicatorBar(signalStrength: info.strengthLevel),
          ],
        ),
        Text("Strength dbm: ${info.strengthDbm}"),
        DashboardItemCard(
          child: Column(
            children: [
              DashboardItem(label: "Operator:", data: info.networkType),
              DashboardItem(label: "Wan IP:", data: info.ipAddress),
              DashboardItem(label: "Networkmask:", data: info.networkmask),
            ],
          ),
        ),
        DashboardItemCard(
          child: Column(
            children: [
              DashboardItem(label: "Wifi Name: ", data: info.wifihotname),
              DashboardItem(label: "Security: ", data: info.wifisafetype),
              DashboardItem(label: "Connected Device: ", data: info.hotcount),
            ],
          ),
        ),
        DashboardItemCard(
          child: Column(
            children: [
              DashboardItem(label: "MAC:", data: info.macAddress),
              DashboardItem(label: "IMEI:", data: info.imei),
              DashboardItem(label: "S/N:", data: info.sn),
            ],
          ),
        ),
      ],
    );
  }

  Future<DeviceInfo> _fetchDashboardData() async {
    const url = "http://192.168.0.1/jsonp_dashboard?callback=";
    final response = await http.get(Uri.parse(url), headers: {});
    var xmlParser = Xml2Json();
    xmlParser.parse(response.body);
    var decodedJson =
        jsonDecode(xmlParser.toOpenRally()) as Map<String, dynamic>;
    return DeviceInfo.fromJson(decodedJson['deviceinfo']);
  }
}
