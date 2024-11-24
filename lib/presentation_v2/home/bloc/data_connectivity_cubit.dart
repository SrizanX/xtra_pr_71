import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../data/network/api/internet_state_api_service.dart';
import '../../../domain/entity/internet/network_info.dart';
import '../../../presentation/home/internet/network_mode.dart';
import 'data_connectivity_state.dart';

class DataConnectivityCubit extends Cubit<DataConnectivityState> {
  DataConnectivityCubit()
      : super(const DataConnectivityState(
          isMobileDataEnabled: false,
          isRoamingEnabled: false,
          networkMode: NetworkMode.secondGeneration,
        )) {
    fetchConnectivityState();
  }

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

  void fetchConnectivityState() async {
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

  void toggleMobileData() async {
    final newMobileDataState = !state.isMobileDataEnabled;
    emit(state.copy(isLoading: true));
    final result = await InternetStateApiService().updateInternetState(
      networkMode: state.networkMode,
      isMobileDataEnabled: newMobileDataState,
      isRoamingEnabled: state.isRoamingEnabled,
    );

    switch (result) {
      case Successful<StateResponse>():
        emit(state.copy(
            isLoading: false, isMobileDataEnabled: newMobileDataState));
      case Failed<StateResponse>():
        emit(state.copy(isLoading: false));
    }
  }

  void toggleRoaming() async {
    final newRoamingState = !state.isRoamingEnabled;
    emit(state.copy(isLoading: true));
    final result = await InternetStateApiService().updateInternetState(
      networkMode: state.networkMode,
      isMobileDataEnabled: state.isMobileDataEnabled,
      isRoamingEnabled: newRoamingState,
    );

    switch (result) {
      case Successful<StateResponse>():
        emit(state.copy(isLoading: false, isRoamingEnabled: newRoamingState));
      case Failed<StateResponse>():
        emit(state.copy(isLoading: false));
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
