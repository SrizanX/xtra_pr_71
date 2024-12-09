import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/entity/network_mode.dart';

part 'network_mode_state.freezed.dart';

@freezed
class NetworkModeState with _$NetworkModeState {
  const factory NetworkModeState({
    @Default(false) bool isLoading,
    @Default(null) String? errorMessage,
    @Default(false) bool isMobileDataEnabled,
    @Default(false) bool isRoamingEnabled,
    @Default(null) NetworkMode? networkMode,
  }) = _NetworkModeState;
}
