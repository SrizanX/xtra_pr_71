// Verifies the demo-mode data stack and the dashboard connectivity status.

import 'package:flutter_test/flutter_test.dart';
import 'package:xtra_pr_71/data/demo/demo_mode.dart';
import 'package:xtra_pr_71/data/shared_preferences/prefs_repository.dart';
import 'package:xtra_pr_71/presentation/home/bloc/dashboard_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/dashboard_state.dart';
import 'package:xtra_pr_71/presentation/login/bloc/login_cubit.dart';
import 'package:xtra_pr_71/presentation/login/bloc/login_state.dart';

void main() {
  setUp(() {
    DemoMode.enabled = true;
    // 0 = polling Off, so the cubit doesn't arm a refresh timer in the test.
    PrefsRepository().dashboardRefreshMs.value = 0;
  });

  tearDown(() => DemoMode.enabled = false);

  test('demo account signs in and enables demo mode without a router', () async {
    DemoMode.enabled = false; // verify login() flips it on
    final login = LoginCubit()
      ..onUsernameChange(DemoMode.username)
      ..onPasswordChange(DemoMode.password);
    login.login();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(DemoMode.enabled, isTrue);
    expect(login.state.loginApiState, isA<LoginSuccessful>());
    await login.close();
  });

  test('demo mode drives the dashboard with sample data, online', () async {
    final cubit = DashboardCubit();
    // Let the constructor's first fetch (demo data) resolve.
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(cubit.state, isA<DashboardSuccessful>());
    final s = cubit.state as DashboardSuccessful;
    expect(s.connectivity, DashboardConnectivity.online);
    expect(s.deviceInfo.wifihotname, 'XTRA-PR71');
    await cubit.close();
  });

  test('markRestarting / markPoweredOff flip status but keep the data',
      () async {
    final cubit = DashboardCubit();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final data = (cubit.state as DashboardSuccessful).deviceInfo;

    cubit.markRestarting();
    final restarting = cubit.state as DashboardSuccessful;
    expect(restarting.connectivity, DashboardConnectivity.restarting);
    // Same last-known snapshot is retained behind the status.
    expect(restarting.deviceInfo, same(data));

    cubit.markPoweredOff();
    expect(
      (cubit.state as DashboardSuccessful).connectivity,
      DashboardConnectivity.poweredOff,
    );
    await cubit.close();
  });
}
