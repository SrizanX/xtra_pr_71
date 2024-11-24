import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../presentation/home/internet/allowance/allowance_card.dart';

part 'data_limit_state.freezed.dart';

@freezed
class DataLimitState with _$DataLimitState {
  const factory DataLimitState({
    @Default(false) bool isLoading,
    @Default(false) bool isUsageLimitEnabled,
    @Default(0) int allowance,
    @Default(AllowanceUnit.mb) AllowanceUnit allowanceUnit,
  }) = _AllowanceState;
}
