// Renders the "router unreachable" failure state of each data screen at phone
// size, to confirm they share one consistent ErrorView (with Try again).
//
//   flutter test test/golden/error_states_test.dart --update-goldens

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xtra_pr_71/presentation/contacts/bloc/contacts_cubit.dart';
import 'package:xtra_pr_71/presentation/contacts/contacts_screen.dart';
import 'package:xtra_pr_71/presentation/devices/bloc/connected_devices_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/apn_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/mac_filter_cubit.dart';
import 'package:xtra_pr_71/presentation/network/network_screen.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_cubit.dart';
import 'package:xtra_pr_71/presentation/sms/messages_screen.dart';

import 'support/fakes.dart';
import 'support/fonts.dart';
import 'support/harness.dart';

void main() {
  setUpAll(() async {
    installScreenshotEnvironment();
    await loadGoldenFonts();
  });

  final screens = <String, Widget Function()>{
    'contacts_error': () => BlocProvider<ContactsCubit>(
          create: (_) => FakeContactsFailedCubit(),
          child: const ContactsScreen(),
        ),
    'messages_error': () => BlocProvider<SmsCubit>(
          create: (_) => FakeSmsFailedCubit(),
          child: const MessagesScreen(),
        ),
    'network_error': () => MultiBlocProvider(
          providers: [
            BlocProvider<ApnCubit>(create: (_) => FakeApnFailedCubit()),
            BlocProvider<MacFilterCubit>(create: (_) => FakeMacFilterCubit()),
            BlocProvider<ConnectedDevicesCubit>(
                create: (_) => FakeConnectedDevicesFailedCubit()),
          ],
          child: const NetworkScreen(),
        ),
  };

  const ff = FormFactor('phone', Size(360, 780), 3);

  for (final entry in screens.entries) {
    testWidgets(entry.key, (tester) async {
      await captureScreen(
        tester,
        name: entry.key,
        ff: ff,
        screen: entry.value,
      );
    });
  }
}
