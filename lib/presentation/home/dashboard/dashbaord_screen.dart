import 'package:flutter/material.dart';
import 'package:xtra_pr_71/data/network/api/dashboard_api_service.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/domain/result.dart';
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
          future: DashboardApiService().fetchDashboardData(),
          builder: (BuildContext context,
              AsyncSnapshot<Result<DeviceInfo>> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data!;
              switch (result) {
                case Successful<DeviceInfo>():
                  return buildDashboardUi(result.data);
                case Failed<DeviceInfo>():
                  return Text(result.message);
              }
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
            SignalStrengthIndicatorBar(signalStrength: "${info.strengthLevel}"),
          ],
        ),
        Text("Strength dbm: ${info.strengthDbm}"),
        DashboardItemCard(
          child: Column(
            children: [
              DashboardItem(label: "Operator:", data: info.networkType),
              DashboardItem(label: "Wan IP:", data: info.ipAddress),
              DashboardItem(label: "Network mask:", data: info.networkmask),
            ],
          ),
        ),
        DashboardItemCard(
          child: Column(
            children: [
              DashboardItem(label: "Wifi Name: ", data: info.wifihotname),
              DashboardItem(label: "Security: ", data: info.wifisafetype),
              DashboardItem(
                  label: "Connected Device: ", data: '${info.hotcount}'),
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
}
