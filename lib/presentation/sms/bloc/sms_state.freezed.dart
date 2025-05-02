// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SmsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(SmsApiEntity sms) smsListSuccessful,
    required TResult Function() smsListFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(SmsApiEntity sms)? smsListSuccessful,
    TResult? Function()? smsListFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(SmsApiEntity sms)? smsListSuccessful,
    TResult Function()? smsListFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SmsListSuccessful value) smsListSuccessful,
    required TResult Function(SmsListFailed value) smsListFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SmsListSuccessful value)? smsListSuccessful,
    TResult? Function(SmsListFailed value)? smsListFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SmsListSuccessful value)? smsListSuccessful,
    TResult Function(SmsListFailed value)? smsListFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsStateCopyWith<$Res> {
  factory $SmsStateCopyWith(SmsState value, $Res Function(SmsState) then) =
      _$SmsStateCopyWithImpl<$Res, SmsState>;
}

/// @nodoc
class _$SmsStateCopyWithImpl<$Res, $Val extends SmsState>
    implements $SmsStateCopyWith<$Res> {
  _$SmsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SmsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SmsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(SmsApiEntity sms) smsListSuccessful,
    required TResult Function() smsListFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(SmsApiEntity sms)? smsListSuccessful,
    TResult? Function()? smsListFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(SmsApiEntity sms)? smsListSuccessful,
    TResult Function()? smsListFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SmsListSuccessful value) smsListSuccessful,
    required TResult Function(SmsListFailed value) smsListFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SmsListSuccessful value)? smsListSuccessful,
    TResult? Function(SmsListFailed value)? smsListFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SmsListSuccessful value)? smsListSuccessful,
    TResult Function(SmsListFailed value)? smsListFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements SmsState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SmsListSuccessfulImplCopyWith<$Res> {
  factory _$$SmsListSuccessfulImplCopyWith(_$SmsListSuccessfulImpl value,
          $Res Function(_$SmsListSuccessfulImpl) then) =
      __$$SmsListSuccessfulImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SmsApiEntity sms});
}

/// @nodoc
class __$$SmsListSuccessfulImplCopyWithImpl<$Res>
    extends _$SmsStateCopyWithImpl<$Res, _$SmsListSuccessfulImpl>
    implements _$$SmsListSuccessfulImplCopyWith<$Res> {
  __$$SmsListSuccessfulImplCopyWithImpl(_$SmsListSuccessfulImpl _value,
      $Res Function(_$SmsListSuccessfulImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sms = null,
  }) {
    return _then(_$SmsListSuccessfulImpl(
      sms: null == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as SmsApiEntity,
    ));
  }
}

/// @nodoc

class _$SmsListSuccessfulImpl implements SmsListSuccessful {
  const _$SmsListSuccessfulImpl({required this.sms});

  @override
  final SmsApiEntity sms;

  @override
  String toString() {
    return 'SmsState.smsListSuccessful(sms: $sms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsListSuccessfulImpl &&
            (identical(other.sms, sms) || other.sms == sms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sms);

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsListSuccessfulImplCopyWith<_$SmsListSuccessfulImpl> get copyWith =>
      __$$SmsListSuccessfulImplCopyWithImpl<_$SmsListSuccessfulImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(SmsApiEntity sms) smsListSuccessful,
    required TResult Function() smsListFailed,
  }) {
    return smsListSuccessful(sms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(SmsApiEntity sms)? smsListSuccessful,
    TResult? Function()? smsListFailed,
  }) {
    return smsListSuccessful?.call(sms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(SmsApiEntity sms)? smsListSuccessful,
    TResult Function()? smsListFailed,
    required TResult orElse(),
  }) {
    if (smsListSuccessful != null) {
      return smsListSuccessful(sms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SmsListSuccessful value) smsListSuccessful,
    required TResult Function(SmsListFailed value) smsListFailed,
  }) {
    return smsListSuccessful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SmsListSuccessful value)? smsListSuccessful,
    TResult? Function(SmsListFailed value)? smsListFailed,
  }) {
    return smsListSuccessful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SmsListSuccessful value)? smsListSuccessful,
    TResult Function(SmsListFailed value)? smsListFailed,
    required TResult orElse(),
  }) {
    if (smsListSuccessful != null) {
      return smsListSuccessful(this);
    }
    return orElse();
  }
}

abstract class SmsListSuccessful implements SmsState {
  const factory SmsListSuccessful({required final SmsApiEntity sms}) =
      _$SmsListSuccessfulImpl;

  SmsApiEntity get sms;

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsListSuccessfulImplCopyWith<_$SmsListSuccessfulImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SmsListFailedImplCopyWith<$Res> {
  factory _$$SmsListFailedImplCopyWith(
          _$SmsListFailedImpl value, $Res Function(_$SmsListFailedImpl) then) =
      __$$SmsListFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmsListFailedImplCopyWithImpl<$Res>
    extends _$SmsStateCopyWithImpl<$Res, _$SmsListFailedImpl>
    implements _$$SmsListFailedImplCopyWith<$Res> {
  __$$SmsListFailedImplCopyWithImpl(
      _$SmsListFailedImpl _value, $Res Function(_$SmsListFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmsListFailedImpl implements SmsListFailed {
  const _$SmsListFailedImpl();

  @override
  String toString() {
    return 'SmsState.smsListFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SmsListFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(SmsApiEntity sms) smsListSuccessful,
    required TResult Function() smsListFailed,
  }) {
    return smsListFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(SmsApiEntity sms)? smsListSuccessful,
    TResult? Function()? smsListFailed,
  }) {
    return smsListFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(SmsApiEntity sms)? smsListSuccessful,
    TResult Function()? smsListFailed,
    required TResult orElse(),
  }) {
    if (smsListFailed != null) {
      return smsListFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SmsListSuccessful value) smsListSuccessful,
    required TResult Function(SmsListFailed value) smsListFailed,
  }) {
    return smsListFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SmsListSuccessful value)? smsListSuccessful,
    TResult? Function(SmsListFailed value)? smsListFailed,
  }) {
    return smsListFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SmsListSuccessful value)? smsListSuccessful,
    TResult Function(SmsListFailed value)? smsListFailed,
    required TResult orElse(),
  }) {
    if (smsListFailed != null) {
      return smsListFailed(this);
    }
    return orElse();
  }
}

abstract class SmsListFailed implements SmsState {
  const factory SmsListFailed() = _$SmsListFailedImpl;
}
