// Fake cubits for the screenshot harness.
//
// Each one subclasses the real cubit and overrides only the public fetch method
// it calls from its constructor, emitting canned [sample_data] instead of
// hitting the router. Dart dispatches the override even though the super
// constructor calls the method, so no network request is ever made.

import 'package:xtra_pr_71/presentation/contacts/bloc/contacts_cubit.dart';
import 'package:xtra_pr_71/presentation/contacts/bloc/contacts_state.dart';
import 'package:xtra_pr_71/presentation/data/bloc/statistics_cubit.dart';
import 'package:xtra_pr_71/presentation/data/bloc/statistics_state.dart';
import 'package:xtra_pr_71/presentation/devices/bloc/connected_devices_cubit.dart';
import 'package:xtra_pr_71/presentation/devices/bloc/connected_devices_state.dart';
import 'package:xtra_pr_71/presentation/home/bloc/dashboard_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/dashboard_state.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_connectivity_cubit.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_limit_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/apn_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/apn_state.dart';
import 'package:xtra_pr_71/presentation/network/bloc/mac_filter_cubit.dart';
import 'package:xtra_pr_71/presentation/network/bloc/mac_filter_state.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_cubit.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_state.dart';
import 'package:xtra_pr_71/presentation/ussd/bloc/ussd_cubit.dart';
import 'package:xtra_pr_71/presentation/ussd/bloc/ussd_state.dart';

import 'sample_data.dart';

class FakeDashboardCubit extends DashboardCubit {
  @override
  Future<void> fetchDashBoardData() async =>
      emit(DashboardSuccessful(deviceInfo: sampleDeviceInfo));
}

class FakeStatisticsCubit extends StatisticsCubit {
  @override
  Future<void> fetchStatistics() async =>
      emit(StatisticsSuccessful(statistics: sampleStatistics));
}

class FakeDataConnectivityCubit extends DataConnectivityCubit {
  @override
  void fetchConnectivityState() => emit(sampleConnectivity);
}

class FakeDataLimitCubit extends DataLimitCubit {
  @override
  void fetchDataLimitState() => emit(sampleDataLimit);
}

class FakeContactsCubit extends ContactsCubit {
  @override
  void fetchContacts() => emit(ContactsSuccessful(contacts: sampleContacts));
}

class FakeSmsCubit extends SmsCubit {
  @override
  void fetchAllSms() => emit(
        SmsState.smsListSuccessful(sms: sampleSms, loadedPage: 1, totalPage: 1),
      );
}

class FakeApnCubit extends ApnCubit {
  @override
  void fetchApnSettings() => emit(ApnSuccessful(settings: sampleApn));
}

class FakeMacFilterCubit extends MacFilterCubit {
  @override
  void fetchMacFilter() => emit(
        const MacFilterState(
          isReady: true,
          denyEnabled: true,
          macs: sampleBlockedMacs,
          issim: true,
        ),
      );
}

class FakeConnectedDevicesCubit extends ConnectedDevicesCubit {
  @override
  void fetchConnectedDevices() =>
      emit(ConnectedDevicesSuccessful(devices: sampleConnectedDevices));
}

class FakeUssdCubit extends UssdCubit {
  FakeUssdCubit() {
    emit(UssdSuccess(response: sampleUssdResponse));
  }
}

// --- failed-state fakes (router unreachable) -------------------------------

const _offline = 'Connection timeout';

class FakeContactsFailedCubit extends ContactsCubit {
  @override
  void fetchContacts() => emit(ContactsFailed(errorMessage: _offline));
}

class FakeSmsFailedCubit extends SmsCubit {
  @override
  void fetchAllSms() => emit(const SmsState.smsListFailed(message: _offline));
}

class FakeApnFailedCubit extends ApnCubit {
  @override
  void fetchApnSettings() => emit(ApnFailed(errorMessage: _offline));
}

class FakeConnectedDevicesFailedCubit extends ConnectedDevicesCubit {
  @override
  void fetchConnectedDevices() =>
      emit(ConnectedDevicesFailed(errorMessage: _offline));
}
