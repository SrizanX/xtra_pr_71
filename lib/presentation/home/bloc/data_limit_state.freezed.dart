// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_limit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DataLimitState {

 bool get isLoading; bool get isUsageLimitEnabled; int get allowance; AllowanceUnit get allowanceUnit; String get totalUsed;
/// Create a copy of DataLimitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataLimitStateCopyWith<DataLimitState> get copyWith => _$DataLimitStateCopyWithImpl<DataLimitState>(this as DataLimitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataLimitState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUsageLimitEnabled, isUsageLimitEnabled) || other.isUsageLimitEnabled == isUsageLimitEnabled)&&(identical(other.allowance, allowance) || other.allowance == allowance)&&(identical(other.allowanceUnit, allowanceUnit) || other.allowanceUnit == allowanceUnit)&&(identical(other.totalUsed, totalUsed) || other.totalUsed == totalUsed));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUsageLimitEnabled,allowance,allowanceUnit,totalUsed);

@override
String toString() {
  return 'DataLimitState(isLoading: $isLoading, isUsageLimitEnabled: $isUsageLimitEnabled, allowance: $allowance, allowanceUnit: $allowanceUnit, totalUsed: $totalUsed)';
}


}

/// @nodoc
abstract mixin class $DataLimitStateCopyWith<$Res>  {
  factory $DataLimitStateCopyWith(DataLimitState value, $Res Function(DataLimitState) _then) = _$DataLimitStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isUsageLimitEnabled, int allowance, AllowanceUnit allowanceUnit, String totalUsed
});




}
/// @nodoc
class _$DataLimitStateCopyWithImpl<$Res>
    implements $DataLimitStateCopyWith<$Res> {
  _$DataLimitStateCopyWithImpl(this._self, this._then);

  final DataLimitState _self;
  final $Res Function(DataLimitState) _then;

/// Create a copy of DataLimitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isUsageLimitEnabled = null,Object? allowance = null,Object? allowanceUnit = null,Object? totalUsed = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUsageLimitEnabled: null == isUsageLimitEnabled ? _self.isUsageLimitEnabled : isUsageLimitEnabled // ignore: cast_nullable_to_non_nullable
as bool,allowance: null == allowance ? _self.allowance : allowance // ignore: cast_nullable_to_non_nullable
as int,allowanceUnit: null == allowanceUnit ? _self.allowanceUnit : allowanceUnit // ignore: cast_nullable_to_non_nullable
as AllowanceUnit,totalUsed: null == totalUsed ? _self.totalUsed : totalUsed // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DataLimitState].
extension DataLimitStatePatterns on DataLimitState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllowanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllowanceState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllowanceState value)  $default,){
final _that = this;
switch (_that) {
case _AllowanceState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllowanceState value)?  $default,){
final _that = this;
switch (_that) {
case _AllowanceState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isUsageLimitEnabled,  int allowance,  AllowanceUnit allowanceUnit,  String totalUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllowanceState() when $default != null:
return $default(_that.isLoading,_that.isUsageLimitEnabled,_that.allowance,_that.allowanceUnit,_that.totalUsed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isUsageLimitEnabled,  int allowance,  AllowanceUnit allowanceUnit,  String totalUsed)  $default,) {final _that = this;
switch (_that) {
case _AllowanceState():
return $default(_that.isLoading,_that.isUsageLimitEnabled,_that.allowance,_that.allowanceUnit,_that.totalUsed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isUsageLimitEnabled,  int allowance,  AllowanceUnit allowanceUnit,  String totalUsed)?  $default,) {final _that = this;
switch (_that) {
case _AllowanceState() when $default != null:
return $default(_that.isLoading,_that.isUsageLimitEnabled,_that.allowance,_that.allowanceUnit,_that.totalUsed);case _:
  return null;

}
}

}

/// @nodoc


class _AllowanceState implements DataLimitState {
  const _AllowanceState({this.isLoading = false, this.isUsageLimitEnabled = false, this.allowance = 0, this.allowanceUnit = AllowanceUnit.mb, this.totalUsed = ''});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isUsageLimitEnabled;
@override@JsonKey() final  int allowance;
@override@JsonKey() final  AllowanceUnit allowanceUnit;
@override@JsonKey() final  String totalUsed;

/// Create a copy of DataLimitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllowanceStateCopyWith<_AllowanceState> get copyWith => __$AllowanceStateCopyWithImpl<_AllowanceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllowanceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUsageLimitEnabled, isUsageLimitEnabled) || other.isUsageLimitEnabled == isUsageLimitEnabled)&&(identical(other.allowance, allowance) || other.allowance == allowance)&&(identical(other.allowanceUnit, allowanceUnit) || other.allowanceUnit == allowanceUnit)&&(identical(other.totalUsed, totalUsed) || other.totalUsed == totalUsed));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUsageLimitEnabled,allowance,allowanceUnit,totalUsed);

@override
String toString() {
  return 'DataLimitState(isLoading: $isLoading, isUsageLimitEnabled: $isUsageLimitEnabled, allowance: $allowance, allowanceUnit: $allowanceUnit, totalUsed: $totalUsed)';
}


}

/// @nodoc
abstract mixin class _$AllowanceStateCopyWith<$Res> implements $DataLimitStateCopyWith<$Res> {
  factory _$AllowanceStateCopyWith(_AllowanceState value, $Res Function(_AllowanceState) _then) = __$AllowanceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isUsageLimitEnabled, int allowance, AllowanceUnit allowanceUnit, String totalUsed
});




}
/// @nodoc
class __$AllowanceStateCopyWithImpl<$Res>
    implements _$AllowanceStateCopyWith<$Res> {
  __$AllowanceStateCopyWithImpl(this._self, this._then);

  final _AllowanceState _self;
  final $Res Function(_AllowanceState) _then;

/// Create a copy of DataLimitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isUsageLimitEnabled = null,Object? allowance = null,Object? allowanceUnit = null,Object? totalUsed = null,}) {
  return _then(_AllowanceState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUsageLimitEnabled: null == isUsageLimitEnabled ? _self.isUsageLimitEnabled : isUsageLimitEnabled // ignore: cast_nullable_to_non_nullable
as bool,allowance: null == allowance ? _self.allowance : allowance // ignore: cast_nullable_to_non_nullable
as int,allowanceUnit: null == allowanceUnit ? _self.allowanceUnit : allowanceUnit // ignore: cast_nullable_to_non_nullable
as AllowanceUnit,totalUsed: null == totalUsed ? _self.totalUsed : totalUsed // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
