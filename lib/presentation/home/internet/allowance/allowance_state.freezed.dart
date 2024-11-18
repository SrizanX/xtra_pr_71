// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allowance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllowanceState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUsageLimitEnabled => throw _privateConstructorUsedError;
  int get allowance => throw _privateConstructorUsedError;
  AllowanceUnit get allowanceUnit => throw _privateConstructorUsedError;

  /// Create a copy of AllowanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllowanceStateCopyWith<AllowanceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllowanceStateCopyWith<$Res> {
  factory $AllowanceStateCopyWith(
          AllowanceState value, $Res Function(AllowanceState) then) =
      _$AllowanceStateCopyWithImpl<$Res, AllowanceState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isUsageLimitEnabled,
      int allowance,
      AllowanceUnit allowanceUnit});
}

/// @nodoc
class _$AllowanceStateCopyWithImpl<$Res, $Val extends AllowanceState>
    implements $AllowanceStateCopyWith<$Res> {
  _$AllowanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllowanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUsageLimitEnabled = null,
    Object? allowance = null,
    Object? allowanceUnit = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsageLimitEnabled: null == isUsageLimitEnabled
          ? _value.isUsageLimitEnabled
          : isUsageLimitEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      allowance: null == allowance
          ? _value.allowance
          : allowance // ignore: cast_nullable_to_non_nullable
              as int,
      allowanceUnit: null == allowanceUnit
          ? _value.allowanceUnit
          : allowanceUnit // ignore: cast_nullable_to_non_nullable
              as AllowanceUnit,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllowanceStateImplCopyWith<$Res>
    implements $AllowanceStateCopyWith<$Res> {
  factory _$$AllowanceStateImplCopyWith(_$AllowanceStateImpl value,
          $Res Function(_$AllowanceStateImpl) then) =
      __$$AllowanceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isUsageLimitEnabled,
      int allowance,
      AllowanceUnit allowanceUnit});
}

/// @nodoc
class __$$AllowanceStateImplCopyWithImpl<$Res>
    extends _$AllowanceStateCopyWithImpl<$Res, _$AllowanceStateImpl>
    implements _$$AllowanceStateImplCopyWith<$Res> {
  __$$AllowanceStateImplCopyWithImpl(
      _$AllowanceStateImpl _value, $Res Function(_$AllowanceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllowanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUsageLimitEnabled = null,
    Object? allowance = null,
    Object? allowanceUnit = null,
  }) {
    return _then(_$AllowanceStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsageLimitEnabled: null == isUsageLimitEnabled
          ? _value.isUsageLimitEnabled
          : isUsageLimitEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      allowance: null == allowance
          ? _value.allowance
          : allowance // ignore: cast_nullable_to_non_nullable
              as int,
      allowanceUnit: null == allowanceUnit
          ? _value.allowanceUnit
          : allowanceUnit // ignore: cast_nullable_to_non_nullable
              as AllowanceUnit,
    ));
  }
}

/// @nodoc

class _$AllowanceStateImpl implements _AllowanceState {
  const _$AllowanceStateImpl(
      {this.isLoading = false,
      this.isUsageLimitEnabled = false,
      this.allowance = 0,
      this.allowanceUnit = AllowanceUnit.mb});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUsageLimitEnabled;
  @override
  @JsonKey()
  final int allowance;
  @override
  @JsonKey()
  final AllowanceUnit allowanceUnit;

  @override
  String toString() {
    return 'AllowanceState(isLoading: $isLoading, isUsageLimitEnabled: $isUsageLimitEnabled, allowance: $allowance, allowanceUnit: $allowanceUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllowanceStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUsageLimitEnabled, isUsageLimitEnabled) ||
                other.isUsageLimitEnabled == isUsageLimitEnabled) &&
            (identical(other.allowance, allowance) ||
                other.allowance == allowance) &&
            (identical(other.allowanceUnit, allowanceUnit) ||
                other.allowanceUnit == allowanceUnit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, isUsageLimitEnabled, allowance, allowanceUnit);

  /// Create a copy of AllowanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllowanceStateImplCopyWith<_$AllowanceStateImpl> get copyWith =>
      __$$AllowanceStateImplCopyWithImpl<_$AllowanceStateImpl>(
          this, _$identity);
}

abstract class _AllowanceState implements AllowanceState {
  const factory _AllowanceState(
      {final bool isLoading,
      final bool isUsageLimitEnabled,
      final int allowance,
      final AllowanceUnit allowanceUnit}) = _$AllowanceStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isUsageLimitEnabled;
  @override
  int get allowance;
  @override
  AllowanceUnit get allowanceUnit;

  /// Create a copy of AllowanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllowanceStateImplCopyWith<_$AllowanceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
