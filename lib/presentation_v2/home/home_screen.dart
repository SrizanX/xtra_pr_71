import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/dashboard/signal_strength_indicator_widget.dart';
import 'package:xtra_pr_71/presentation_v2/components/app_dialog_widget.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/dashboard_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/dashboard_state.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/data_connectivity_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/data_connectivity_state.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/data_limit_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/data_limit_state.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/battery_indicator.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/power_button.dart';
import 'package:xtra_pr_71/presentation_v2/home/components/toggle_button.dart';
import 'package:xtra_pr_71/presentation_v2/settings/settings_route.dart';

import '../components/app_error_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            switch (state) {
              case DashboardLoading():
                return const Center(child: CircularProgressIndicator());
              case DashboardFailed():
                return ErrorView(errorMessage: (state).errorMessage);
              case DashboardSuccessful():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildAppBar(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(state.deviceInfo.networkType),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BatteryIndicator(
                          capacity: double.parse((state)
                              .deviceInfo
                              .batteryPercent
                              .replaceAll('%', '')),
                          height: 120,
                          width: 80,
                        ),
                        SignalStrengthIndicatorBar(
                          signalStrength: "${state.deviceInfo.strengthLevel}",
                          height: 120,
                        ),
                      ],
                    )),
                    buildToggleButtons(),
                    const SizedBox(
                      height: 32,
                    ),
                    buildPowerButton(context)
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
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
            onPressed: () {
              Navigator.pushNamed(context, SettingsRoute.route);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocSelector<DataConnectivityCubit, DataConnectivityState, bool>(
          selector: (state) => state.isMobileDataEnabled,
          builder: (context, isMobileDataEnabled) {
            return ToggleButton(
              icon: Icons.mobiledata_off,
              label: "Data",
              isOn: isMobileDataEnabled,
              onTap: () {
                context.read<DataConnectivityCubit>().toggleMobileData();
              },
            );
          },
        ),
        BlocSelector<DataConnectivityCubit, DataConnectivityState, bool>(
          selector: (state) => state.isRoamingEnabled,
          builder: (context, isRoamingEnabled) {
            return ToggleButton(
              icon: Icons.travel_explore,
              label: "Roaming",
              onTap: () {
                context.read<DataConnectivityCubit>().toggleRoaming();
              },
              isOn: isRoamingEnabled,
            );
          },
        ),
        BlocBuilder<DataLimitCubit, DataLimitState>(builder: (context, state) {
          return ToggleButton(
            icon: Icons.close_fullscreen_sharp,
            label: "Limit",
            isOn: state.isUsageLimitEnabled,
            onTap: () {
              context.read<DataLimitCubit>().toggleLimit();
            },
          );
        }),
      ],
    );
  }

  Widget buildPowerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: PowerButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AppDialogWidget(
                  title: "Shutdown",
                  message: "Are you sure?",
                  onPositiveButtonClick: () {
                    Navigator.pop(context);
                    //context.read<>();
                  },
                );
              });
        },
      ),
    );
  }
}
