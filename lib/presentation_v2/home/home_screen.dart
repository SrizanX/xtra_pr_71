import 'package:flutter/material.dart';
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
          Row(
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
          ),
          const SizedBox(
            height: 200,
          ),
          const Row(
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
          ),
          const SizedBox(
            height: 32,
          ),
          const PowerButton()
        ],
      )),
    );
  }
}
