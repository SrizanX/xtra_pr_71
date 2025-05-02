import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entity/internet/internet_allowance.dart';
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
