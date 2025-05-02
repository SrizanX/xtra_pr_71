import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/domain/result.dart';
import '../../../data/network/api/dashboard_api_service.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardLoading()){
    fetchDashBoardData();
  }

  void fetchDashBoardData() async {
    emit(DashboardLoading());
    final result = await DashboardApiService().fetchDashboardData();
    switch (result) {
      case Successful<DeviceInfo>():
        emit(DashboardSuccessful(deviceInfo: result.data));
      case Failed<DeviceInfo>():
        emit(DashboardFailed(errorMessage: result.message));
    }
  }
}
