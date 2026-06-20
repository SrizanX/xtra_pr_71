import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/result.dart';
import '../../../data/network/api/router_control_api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeSate> {
  HomeCubit() : super(HomeSate());

  void reboot() async {
    final result = await RouterControlApiService().restart();
    switch (result) {
      case Successful():
        debugPrint('${result.data}');
      case Failed():
        debugPrint(result.message);
    }
  }

  void powerOff() async {
    final result = await RouterControlApiService().powerOff();
    switch (result) {
      case Successful():
        debugPrint('${result.data}');
      case Failed():
        debugPrint(result.message);
    }
  }
}
