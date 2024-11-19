import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/api/internet_allowance_api_service.dart';
import 'package:xtra_pr_71/domain/entity/internet/internet_allowance.dart';
import 'package:xtra_pr_71/presentation/home/internet/allowance/allowance_card.dart';

import '../../../../domain/result.dart';
import 'allowance_state.dart';

class AllowanceCubit extends Cubit<AllowanceState> {
  AllowanceCubit() : super(const AllowanceState());

  void updateMobileData(bool value) {
    emit(state.copyWith(isUsageLimitEnabled: value));
  }

  void updateAllowanceUnit(AllowanceUnit? unit) {
    emit(state.copyWith(allowanceUnit: unit!));
  }

  void updateAllowance(int allowance) {
    emit(state.copyWith(allowance: allowance));
  }

  void fetchConStat() async {
    emit(state.copyWith(isLoading: true));
    var allowanceData = await InternetAllowanceApiService().fetchDataUsage();
    switch (allowanceData) {
      case Successful<InternetAllowanceEntity>():
        String numericPart =
            allowanceData.data.allowanceData.replaceAll(RegExp(r'[^\d.]'), '');
        int size = double.parse(numericPart).toInt();

        AllowanceUnit unit = allowanceData.data.allowanceData.contains("MB")
            ? AllowanceUnit.mb
            : AllowanceUnit.gb;

        emit(state.copyWith(
            isLoading: false,
            isUsageLimitEnabled: allowanceData.data.dataLimit,
            allowance: size,
            allowanceUnit: unit));
      case Failed<InternetAllowanceEntity>():
        emit(state.copyWith(isLoading: false));
    }
  }

  void apply() async {
    emit(state.copyWith(isLoading: true));
    final response =
        await InternetAllowanceApiService().updateInternetAllowance(
      isUsageLimitEnabled: state.isUsageLimitEnabled,
      allowance: state.allowance,
      allowanceUnit: state.allowanceUnit,
    );

    switch (response) {
      case Successful():
        emit(state.copyWith(isLoading: false));
      case Failed():
        emit(state.copyWith(isLoading: false));
    }
  }
}
