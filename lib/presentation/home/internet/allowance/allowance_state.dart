import 'package:freezed_annotation/freezed_annotation.dart';

import 'allowance_card.dart';

part 'allowance_state.freezed.dart';

@freezed
class AllowanceState with _$AllowanceState {
  const factory AllowanceState({
    @Default(false) bool isLoading,
    @Default(false) bool isUsageLimitEnabled,
    @Default(0) int allowance,
    @Default(AllowanceUnit.mb) AllowanceUnit allowanceUnit,
  }) = _AllowanceState;
}
