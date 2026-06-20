// Play Store screenshot generator.
//
// Renders each screen with canned sample data at three form factors (phone,
// 7" tablet, 10" tablet) and writes PNGs under test/golden/goldens/.
//
//   Generate / refresh:  flutter test test/golden --update-goldens
//   Verify unchanged:    flutter test test/golden
//
// Output files are named  <screen>_<formfactor>.png  and are sized exactly to
// Play's requirements (phone 1080×2340, 7" 1200×1920, 10" 1600×2560).

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xtra_pr_71/presentation/contacts/bloc/contacts_cubit.dart';
import 'package:xtra_pr_71/presentation/contacts/contacts_screen.dart';
import 'package:xtra_pr_71/presentation/data/bloc/statistics_cubit.dart';
import 'package:xtra_pr_71/presentation/devices/bloc/connected_devices_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/dashboard_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_connectivity_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_limit_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/home_cubit.dart';
import 'package:xtra_pr_71/presentation/home/home_screen.dart';
import 'package:xtra_pr_71/presentation/login/bloc/login_cubit.dart';
import 'package:xtra_pr_71/presentation/login/login_screen.dart';
import 'package:xtra_pr_71/presentation/network/bloc/apn_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/mac_filter_cubit.dart';
import 'package:xtra_pr_71/presentation/network/network_screen.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_cubit.dart';
import 'package:xtra_pr_71/presentation/sms/messages_screen.dart';
import 'package:xtra_pr_71/presentation/ussd/bloc/ussd_cubit.dart';
import 'package:xtra_pr_71/presentation/ussd/ussd_screen.dart';

import 'support/fakes.dart';
import 'support/fonts.dart';
import 'support/harness.dart';

void main() {
  setUpAll(() async {
    installScreenshotEnvironment();
    await loadGoldenFonts();
  });

  // name → builds the screen (with its fake cubits) fresh for each shot.
  final screens = <String, Widget Function()>{
    'login': () => BlocProvider(
          create: (_) => LoginCubit(),
          child: const LoginScreen(),
        ),
    'home': () => MultiBlocProvider(
          providers: [
            BlocProvider<DashboardCubit>(create: (_) => FakeDashboardCubit()),
            BlocProvider<DataConnectivityCubit>(
                create: (_) => FakeDataConnectivityCubit()),
            BlocProvider<DataLimitCubit>(create: (_) => FakeDataLimitCubit()),
            BlocProvider<StatisticsCubit>(create: (_) => FakeStatisticsCubit()),
            BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
          ],
          child: const HomeScreen(),
        ),
    'network': () => MultiBlocProvider(
          providers: [
            BlocProvider<ApnCubit>(create: (_) => FakeApnCubit()),
            BlocProvider<MacFilterCubit>(create: (_) => FakeMacFilterCubit()),
            BlocProvider<ConnectedDevicesCubit>(
                create: (_) => FakeConnectedDevicesCubit()),
          ],
          child: const NetworkScreen(),
        ),
    'contacts': () => BlocProvider<ContactsCubit>(
          create: (_) => FakeContactsCubit(),
          child: const ContactsScreen(),
        ),
    'messages': () => BlocProvider<SmsCubit>(
          create: (_) => FakeSmsCubit(),
          child: const MessagesScreen(),
        ),
    'ussd': () => BlocProvider<UssdCubit>(
          create: (_) => FakeUssdCubit(),
          child: const UssdScreen(),
        ),
  };

  for (final entry in screens.entries) {
    group(entry.key, () {
      for (final ff in formFactors) {
        testWidgets('${entry.key} @ ${ff.name}', (tester) async {
          await captureScreen(
            tester,
            name: entry.key,
            ff: ff,
            screen: entry.value,
          );
        });
      }
    });
  }
}
