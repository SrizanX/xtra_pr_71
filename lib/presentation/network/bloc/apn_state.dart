import '../../../domain/entity/apn/apn_settings.dart';

sealed class ApnState {}

class ApnLoading extends ApnState {}

class ApnFailed extends ApnState {
  final String errorMessage;
  ApnFailed({required this.errorMessage});
}

class ApnSuccessful extends ApnState {
  final ApnSettings settings;
  ApnSuccessful({required this.settings});
}
