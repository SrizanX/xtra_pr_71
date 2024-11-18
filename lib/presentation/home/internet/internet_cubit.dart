import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/api/dashboard_api_service.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../data/network/api/internet_state_api_service.dart';
import '../../../domain/entity/internet/network_info.dart';
import 'network_mode.dart';

class InternetState {
  final bool isLoading;
  final bool isMobileDataEnabled;
  final bool isRoamingEnabled;
  final NetworkMode networkMode;

  const InternetState({
    this.isLoading = true,
    required this.isMobileDataEnabled,
    required this.isRoamingEnabled,
    required this.networkMode,
  });

  InternetState copy({
    bool? isLoading,
    bool? isMobileDataEnabled,
    bool? isRoamingEnabled,
    NetworkMode? networkMode,
  }) {
    return InternetState(
      isLoading: isLoading ?? this.isLoading,
      isMobileDataEnabled: isMobileDataEnabled ?? this.isMobileDataEnabled,
      isRoamingEnabled: isRoamingEnabled ?? this.isRoamingEnabled,
      networkMode: networkMode ?? this.networkMode,
    );
  }
}

class InternetCubit extends Cubit<InternetState> {
  InternetCubit()
      : super(const InternetState(
          isMobileDataEnabled: false,
          isRoamingEnabled: false,
          networkMode: NetworkMode.secondGeneration,
        ));

  void updateNetworkMode(NetworkMode? selected) {
    emit(state.copy(networkMode: selected));
  }

  // Update switch 1
  void updateMobileData(bool value) {
    emit(state.copy(isMobileDataEnabled: value));
  }

  // Update switch 2
  void updateRoaming(bool value) {
    emit(state.copy(isRoamingEnabled: value));
  }

  void fetchConStat() async {
    var networkInfo = await InternetStateApiService().getInternetState();
    switch (networkInfo) {
      case Successful<NetworkInfo>():
        emit(state.copy(
            isLoading: false,
            isMobileDataEnabled: networkInfo.data.isDataOpen,
            isRoamingEnabled: networkInfo.data.isRoaming,
            networkMode: NetworkMode.values[networkInfo.data.netType]));
      case Failed<NetworkInfo>():
      // TODO: Handle this case.
    }
  }

  void apply() async {
    emit(state.copy(isLoading: true));
    await InternetStateApiService().updateInternetState(
      networkMode: state.networkMode,
      isMobileDataEnabled: state.isMobileDataEnabled,
      isRoamingEnabled: state.isRoamingEnabled,
    );
    emit(state.copy(isLoading: false));
  }
}
