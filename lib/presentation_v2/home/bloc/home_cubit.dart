import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation_v2/home/bloc/home_state.dart';

import '../../../data/network/api/router_control_api_service.dart';

class HomeCubit extends Cubit<HomeSate> {
  HomeCubit() : super(HomeSate());

  void powerOff() async {
    final result = await RouterControlApiService().powerOff();
    switch (result) {
      case Successful():
        print(result.data);
      case Failed():
        print(result.message);
    }
  }
}
