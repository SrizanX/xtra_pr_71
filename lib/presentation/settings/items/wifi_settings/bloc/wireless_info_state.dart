class WirelessInfoState {
  final bool isLoading;
  String wifiName;
  String password;
  double maxDevices;

  WirelessInfoState({
    this.isLoading = false,
    required this.wifiName,
    required this.password,
    required this.maxDevices,
  });

  WirelessInfoState copyWith({
    bool? isLoading,
    String? wifiName,
    String? password,
    double? maxDevices,
  }) {
    return WirelessInfoState(
      isLoading: isLoading ?? this.isLoading,
      wifiName: wifiName ?? this.wifiName,
      password: password ?? this.password,
      maxDevices: maxDevices ?? this.maxDevices,
    );
  }
}
