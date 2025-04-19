import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/api/wireless_settings_api_service.dart';
import 'package:xtra_pr_71/domain/entity/wireless/wireless_info.dart';
import 'package:xtra_pr_71/domain/result.dart';

import 'wireless_info_state.dart';

class WirelessInfoCubit extends Cubit<WirelessInfoState> {
  WirelessInfoCubit()
      : super(WirelessInfoState(
          wifiName: "",
          password: "",
          maxDevices: 1,
        )){
    fetchWirelessSettings();
  }

  void onUpdateWifiName({required String wifiName}) {
    emit(state.copyWith(wifiName: wifiName));
  }

  void onUpdatePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void onUpdateMaxDeviceCount({required double maxDevices}) {
    emit(state.copyWith(maxDevices: maxDevices));
  }

  void fetchWirelessSettings() async {
    emit(state.copyWith(isLoading: true));
    final result = await WirelessSettingsApiService().fetchWirelessSettings();

    switch (result) {
      case Successful<WirelessInfo>():
        emit(state.copyWith(
          isLoading: false,
          wifiName: result.data.wifiName,
          password: result.data.password,
          maxDevices: result.data.maxnum.toDouble(),
        ));
      case Failed<WirelessInfo>():
    }
  }

  void updateWirelessSettings() async {
    emit(state.copyWith(isLoading: true));
    final response = await WirelessSettingsApiService().updateWirelessSettings(
      wifiName: state.wifiName,
      password: state.password,
      maxDeviceCount: state.maxDevices,
    );

    switch (response) {
      case Successful():
        emit(state.copyWith(isLoading: false));
      case Failed():
        emit(state.copyWith(isLoading: false));
    }
  }
}
