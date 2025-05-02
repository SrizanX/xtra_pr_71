import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import '../../../../../data/network/api/internet_state_api_service.dart';
import '../../../../../domain/entity/internet/network_info.dart';
import '../../../../../domain/entity/network_mode.dart';
import '../../../../../domain/result.dart';
import 'network_mode_state.dart';

class NetworkModeCubit extends Cubit<NetworkModeState> {
  NetworkModeCubit() : super(const NetworkModeState()) {
    fetchCurrentNetworkSettings();
  }

  void updateNetworkMode(NetworkMode? selected) {
    applyRouterNetworkSettings(networkMode: selected);
  }

  void fetchCurrentNetworkSettings() async {
    var result = await InternetStateApiService().getInternetState();
    switch (result) {
      case Successful<NetworkInfo>():
        emit(state.copyWith(
            isLoading: false,
            isMobileDataEnabled: result.data.isDataOpen,
            isRoamingEnabled: result.data.isRoaming,
            networkMode: NetworkMode.values[result.data.netType]));
      case Failed<NetworkInfo>():
        emit(state.copyWith(isLoading: false, errorMessage: result.message));
    }
  }

  void applyRouterNetworkSettings({
    NetworkMode? networkMode,
    bool? isMobileDataEnabled,
    bool? isRoamingEnabled,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await InternetStateApiService().updateInternetState(
      networkMode:
          networkMode ?? (state.networkMode ?? NetworkMode.forthGeneration),
      isMobileDataEnabled: isMobileDataEnabled ?? state.isMobileDataEnabled,
      isRoamingEnabled: isRoamingEnabled ?? state.isRoamingEnabled,
    );

    switch (result) {
      case Successful<StateResponse>():
        emit(state.copyWith(
          isLoading: false,
          networkMode:
              networkMode ?? (state.networkMode ?? NetworkMode.forthGeneration),
          isMobileDataEnabled: isMobileDataEnabled ?? state.isMobileDataEnabled,
          isRoamingEnabled: isRoamingEnabled ?? state.isRoamingEnabled,
        ));
        break;
      case Failed<StateResponse>():
        emit(state.copyWith(isLoading: false, errorMessage: result.message));
    }
  }
}
