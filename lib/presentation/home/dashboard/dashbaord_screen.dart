import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';

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
            SignalTowerIndicator(signalStrength: info.strengthLevel),
          ],
        ),
        Text("Strength dbm: ${info.strengthDbm}"),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(info.networkType),
                Text("Wan IP: ${info.ipAddress}"),
                Text(info.networkmask),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text("SNID: ${info.wifihotname}"),
                Text("Security: ${info.wifisafetype}"),
                Text("Hot Count: ${info.hotcount}"),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text("MAC: ${info.macAddress}"),
                Text("IMEI: ${info.imei}"),
                Text("S/N: ${info.sn}"),
              ],
            ),
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

class SignalTowerIndicator extends StatelessWidget {
  final String signalStrength;

  const SignalTowerIndicator({
    super.key,
    required this.signalStrength,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the signal strength (it should be between 1 and 5)
    final int strength = int.tryParse(signalStrength) ?? 0;

    // Ensure the value is within the range 1-5
    final level = strength.clamp(1, 5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Signal tower icon (small tower for visual effect)
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              width: 12, // Narrow bars for a more old-school look
              height: (index + 1) * 38.0, // Gradually increasing height
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index < level
                    ? _getColorForSignalLevel(level)
                    : Colors.grey[300], // Empty bars are light grey
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        // Display signal strength level as text
        Text(
          "$level / 5",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getColorForSignalLevel(int level) {
    // Determine color based on signal strength
    if (level == 5) {
      return Colors.green; // Excellent signal
    } else if (level == 4) {
      return Colors.lightGreen;
    } else if (level == 3) {
      return Colors.yellow;
    } else if (level == 2) {
      return Colors.orange;
    } else {
      return Colors.red; // Poor signal
    }
  }
}

class CellularTowerIcon extends StatelessWidget {
  const CellularTowerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 200), // The size of the icon
      painter: CellularTowerPainter(),
    );
  }
}

class CellularTowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Drawing the tower (triangle)
    Path towerPath = Path()
      ..moveTo(size.width / 2, size.height * 0.1) // top of the tower
      ..lineTo(size.width * 0.1, size.height * 0.8) // left bottom of the tower
      ..lineTo(size.width * 0.9, size.height * 0.8) // right bottom of the tower
      ..close();

    canvas.drawPath(towerPath, paint);

    // Drawing the base of the tower (rectangle)
    paint.color = Colors.blueAccent;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.4, size.height * 0.8, size.width * 0.2,
            size.height * 0.1),
        paint);

    // Drawing antennas on top
    paint.color = Colors.black;
    canvas.drawLine(Offset(size.width * 0.2, size.height * 0.1),
        Offset(size.width * 0.2, size.height * 0.05), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.1),
        Offset(size.width * 0.8, size.height * 0.05), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.5, size.height * 0.05), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SignalStrengthIndicator extends StatelessWidget {
  final String signalStrength;

  const SignalStrengthIndicator({
    super.key,
    required this.signalStrength,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the signal strength (it should be between 1 and 5)
    final int strength = int.tryParse(signalStrength) ?? 0;

    // Ensure the value is within the range 1-5
    final level = strength.clamp(1, 5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Signal bar showing the strength
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              width: 20,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < level
                    ? _getColorForSignalLevel(level)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        // Display signal strength level as text
        Text(
          "$level / 5",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getColorForSignalLevel(int level) {
    // Determine color based on signal strength
    if (level == 5) {
      return Colors.green;
    } else if (level == 4) {
      return Colors.lightGreen;
    } else if (level == 3) {
      return Colors.yellow;
    } else if (level == 2) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class RealisticBatteryIndicator extends StatelessWidget {
  final String percentage;

  const RealisticBatteryIndicator({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final parsedPercentage = double.parse(percentage.replaceAll('%', ''));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Battery body
            Container(
              width: 180,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: parsedPercentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getColorForPercentage(parsedPercentage),
                    borderRadius: BorderRadius.horizontal(
                      left: const Radius.circular(6),
                      right: Radius.circular(parsedPercentage == 100 ? 6 : 0),
                    ),
                  ),
                ),
              ),
            ),
            // Battery tip
            Positioned(
              right: -10,
              top: 20,
              bottom: 20,
              child: Container(
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Display percentage text
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage > 50) {
      return Colors.green;
    } else if (percentage > 20) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
