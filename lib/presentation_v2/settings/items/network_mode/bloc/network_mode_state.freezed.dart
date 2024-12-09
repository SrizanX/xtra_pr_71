// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_mode_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkModeState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isMobileDataEnabled => throw _privateConstructorUsedError;
  bool get isRoamingEnabled => throw _privateConstructorUsedError;
  NetworkMode? get networkMode => throw _privateConstructorUsedError;

  /// Create a copy of NetworkModeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkModeStateCopyWith<NetworkModeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkModeStateCopyWith<$Res> {
  factory $NetworkModeStateCopyWith(
          NetworkModeState value, $Res Function(NetworkModeState) then) =
      _$NetworkModeStateCopyWithImpl<$Res, NetworkModeState>;
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      bool isMobileDataEnabled,
      bool isRoamingEnabled,
      NetworkMode? networkMode});
}

/// @nodoc
class _$NetworkModeStateCopyWithImpl<$Res, $Val extends NetworkModeState>
    implements $NetworkModeStateCopyWith<$Res> {
  _$NetworkModeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkModeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isMobileDataEnabled = null,
    Object? isRoamingEnabled = null,
    Object? networkMode = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isMobileDataEnabled: null == isMobileDataEnabled
          ? _value.isMobileDataEnabled
          : isMobileDataEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isRoamingEnabled: null == isRoamingEnabled
          ? _value.isRoamingEnabled
          : isRoamingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      networkMode: freezed == networkMode
          ? _value.networkMode
          : networkMode // ignore: cast_nullable_to_non_nullable
              as NetworkMode?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkModeStateImplCopyWith<$Res>
    implements $NetworkModeStateCopyWith<$Res> {
  factory _$$NetworkModeStateImplCopyWith(_$NetworkModeStateImpl value,
          $Res Function(_$NetworkModeStateImpl) then) =
      __$$NetworkModeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      bool isMobileDataEnabled,
      bool isRoamingEnabled,
      NetworkMode? networkMode});
}

/// @nodoc
class __$$NetworkModeStateImplCopyWithImpl<$Res>
    extends _$NetworkModeStateCopyWithImpl<$Res, _$NetworkModeStateImpl>
    implements _$$NetworkModeStateImplCopyWith<$Res> {
  __$$NetworkModeStateImplCopyWithImpl(_$NetworkModeStateImpl _value,
      $Res Function(_$NetworkModeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkModeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isMobileDataEnabled = null,
    Object? isRoamingEnabled = null,
    Object? networkMode = freezed,
  }) {
    return _then(_$NetworkModeStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isMobileDataEnabled: null == isMobileDataEnabled
          ? _value.isMobileDataEnabled
          : isMobileDataEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isRoamingEnabled: null == isRoamingEnabled
          ? _value.isRoamingEnabled
          : isRoamingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      networkMode: freezed == networkMode
          ? _value.networkMode
          : networkMode // ignore: cast_nullable_to_non_nullable
              as NetworkMode?,
    ));
  }
}

/// @nodoc

class _$NetworkModeStateImpl implements _NetworkModeState {
  const _$NetworkModeStateImpl(
      {this.isLoading = false,
      this.errorMessage = null,
      this.isMobileDataEnabled = false,
      this.isRoamingEnabled = false,
      this.networkMode = null});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isMobileDataEnabled;
  @override
  @JsonKey()
  final bool isRoamingEnabled;
  @override
  @JsonKey()
  final NetworkMode? networkMode;

  @override
  String toString() {
    return 'NetworkModeState(isLoading: $isLoading, errorMessage: $errorMessage, isMobileDataEnabled: $isMobileDataEnabled, isRoamingEnabled: $isRoamingEnabled, networkMode: $networkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkModeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isMobileDataEnabled, isMobileDataEnabled) ||
                other.isMobileDataEnabled == isMobileDataEnabled) &&
            (identical(other.isRoamingEnabled, isRoamingEnabled) ||
                other.isRoamingEnabled == isRoamingEnabled) &&
            (identical(other.networkMode, networkMode) ||
                other.networkMode == networkMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, errorMessage,
      isMobileDataEnabled, isRoamingEnabled, networkMode);

  /// Create a copy of NetworkModeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkModeStateImplCopyWith<_$NetworkModeStateImpl> get copyWith =>
      __$$NetworkModeStateImplCopyWithImpl<_$NetworkModeStateImpl>(
          this, _$identity);
}

abstract class _NetworkModeState implements NetworkModeState {
  const factory _NetworkModeState(
      {final bool isLoading,
      final String? errorMessage,
      final bool isMobileDataEnabled,
      final bool isRoamingEnabled,
      final NetworkMode? networkMode}) = _$NetworkModeStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get isMobileDataEnabled;
  @override
  bool get isRoamingEnabled;
  @override
  NetworkMode? get networkMode;

  /// Create a copy of NetworkModeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkModeStateImplCopyWith<_$NetworkModeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
