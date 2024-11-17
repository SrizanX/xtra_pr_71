import 'package:flutter_bloc/flutter_bloc.dart';

class WirelessState {
  String ssid;
  String password;
  String maxDevices;

  WirelessState(this.ssid, this.password, this.maxDevices);
}

class WirelessInfoCubit extends Cubit<WirelessState> {
  WirelessInfoCubit(super.initialState);
}
