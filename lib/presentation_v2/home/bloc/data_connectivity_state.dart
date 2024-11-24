import '../../../presentation/home/internet/network_mode.dart';

class DataConnectivityState {
  final bool isLoading;
  final bool isMobileDataEnabled;
  final bool isRoamingEnabled;
  final NetworkMode networkMode;

  const DataConnectivityState({
    this.isLoading = true,
    required this.isMobileDataEnabled,
    required this.isRoamingEnabled,
    required this.networkMode,
  });

  DataConnectivityState copy({
    bool? isLoading,
    bool? isMobileDataEnabled,
    bool? isRoamingEnabled,
    NetworkMode? networkMode,
  }) {
    return DataConnectivityState(
      isLoading: isLoading ?? this.isLoading,
      isMobileDataEnabled: isMobileDataEnabled ?? this.isMobileDataEnabled,
      isRoamingEnabled: isRoamingEnabled ?? this.isRoamingEnabled,
      networkMode: networkMode ?? this.networkMode,
    );
  }
}

