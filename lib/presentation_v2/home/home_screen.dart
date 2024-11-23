import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/battery_indicator.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/power_button.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/toggle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(41, 43, 68, 100),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildAppBar(context),
          const SizedBox(
            height: 20,
          ),
          const Expanded(
              child: Center(
            child: BatteryIndicator(capacity: 60),
          )),
          buildToggleButtons(),
          const SizedBox(
            height: 32,
          ),
          buildPowerButton()
        ],
      )),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        Expanded(
            child: Center(
          child: Text(
            "XTRA PR71",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
        )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget buildToggleButtons() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ToggleButton(
          icon: Icons.mobiledata_off,
          label: "Data",
          isOn: true,
        ),
        ToggleButton(
          icon: Icons.close_fullscreen_sharp,
          label: "Limit",
          isOn: false,
        ),
        //ToggleButton(icon: Icons.four_g_mobiledata, label: "Limit"),
        ToggleButton(
          icon: Icons.three_g_mobiledata,
          label: "Limit",
          isOn: true,
        ),
      ],
    );
  }

  Widget buildPowerButton() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: PowerButton(),
    );
  }
}
