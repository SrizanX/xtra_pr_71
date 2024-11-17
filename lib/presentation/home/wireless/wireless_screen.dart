import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/domain/entity/wireless/wireless_info.dart';

import '../../../domain/result.dart';

class WirelessScreen extends StatelessWidget {
  const WirelessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wireless"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Result<WirelessInfo>>(
          future: fetch(),
          builder: (context, AsyncSnapshot<Result<WirelessInfo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;

              switch (data) {
                case Successful<WirelessInfo>():
                  final wifiData = data.data;
                  var wifiNameEditingController =
                      TextEditingController(text: wifiData.wifiName);
                  var passwordEditingController =
                      TextEditingController(text: wifiData.password);

                  return Column(
                    children: [
                      const SizedBox(height: 44),
                      TextFormField(
                        controller: wifiNameEditingController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Wifi name",
                            hintText: 'Enter wifi name'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordEditingController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter password"),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),

                      /** max device num */

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Maximum number"),
                          DropdownButton<int>(
                            value: wifiData.maxnum,
                            items: List.generate(
                              10,
                              (a) => DropdownMenuItem(
                                value: a,
                                child: Text('$a'),
                              ),
                            ),
                            onChanged: (selected) {},
                          ),
                        ],
                      ),
                      Slider(
                          min: 1,
                          max: 10,
                          label: "Maximum number",
                          value: wifiData.maxnum.toDouble(),
                          onChanged: (va) {}),
                      FilledButton(
                          onPressed: () {
                            //context.read<InternetCubit>().apply();
                          },
                          child: const Text("Apply"))
                    ],
                  );
                case Failed<WirelessInfo>():
                  return const Text("Error");

                case null:
                  return const Text("Error");
              }
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }

  Future<Result<WirelessInfo>> fetch() async {
    try {
      const url =
          "http://192.168.0.1/jsonp_uapxb_wlan_security_settings?callback=";
      final response = await http.get(Uri.parse(url), headers: {});

      var xmlParser = Xml2Json();
      xmlParser.parse(response.body);
      final decodedResponse = jsonDecode(
          xmlParser.toOpenRally())['com.linsx.webserver.utils.WifiInfo'];
      var ab = WirelessInfo.fromJson(decodedResponse);
      return Successful(data: ab);
    } on Exception catch (e) {
      return Failed(message: "Something went wrong.", exception: e);
    }
  }
}
