// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SmsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmsState()';
}


}

/// @nodoc
class $SmsStateCopyWith<$Res>  {
$SmsStateCopyWith(SmsState _, $Res Function(SmsState) __);
}


/// Adds pattern-matching-related methods to [SmsState].
extension SmsStatePatterns on SmsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( SmsListSuccessful value)?  smsListSuccessful,TResult Function( SmsListFailed value)?  smsListFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case SmsListSuccessful() when smsListSuccessful != null:
return smsListSuccessful(_that);case SmsListFailed() when smsListFailed != null:
return smsListFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( SmsListSuccessful value)  smsListSuccessful,required TResult Function( SmsListFailed value)  smsListFailed,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case SmsListSuccessful():
return smsListSuccessful(_that);case SmsListFailed():
return smsListFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( SmsListSuccessful value)?  smsListSuccessful,TResult? Function( SmsListFailed value)?  smsListFailed,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case SmsListSuccessful() when smsListSuccessful != null:
return smsListSuccessful(_that);case SmsListFailed() when smsListFailed != null:
return smsListFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( SmsApiEntity sms,  int loadedPage,  int totalPage)?  smsListSuccessful,TResult Function()?  smsListFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case SmsListSuccessful() when smsListSuccessful != null:
return smsListSuccessful(_that.sms,_that.loadedPage,_that.totalPage);case SmsListFailed() when smsListFailed != null:
return smsListFailed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( SmsApiEntity sms,  int loadedPage,  int totalPage)  smsListSuccessful,required TResult Function()  smsListFailed,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case SmsListSuccessful():
return smsListSuccessful(_that.sms,_that.loadedPage,_that.totalPage);case SmsListFailed():
return smsListFailed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( SmsApiEntity sms,  int loadedPage,  int totalPage)?  smsListSuccessful,TResult? Function()?  smsListFailed,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case SmsListSuccessful() when smsListSuccessful != null:
return smsListSuccessful(_that.sms,_that.loadedPage,_that.totalPage);case SmsListFailed() when smsListFailed != null:
return smsListFailed();case _:
  return null;

}
}

}

/// @nodoc


class Initial implements SmsState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmsState.initial()';
}


}




/// @nodoc


class SmsListSuccessful implements SmsState {
  const SmsListSuccessful({required this.sms, required this.loadedPage, required this.totalPage});
  

 final  SmsApiEntity sms;
 final  int loadedPage;
 final  int totalPage;

/// Create a copy of SmsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmsListSuccessfulCopyWith<SmsListSuccessful> get copyWith => _$SmsListSuccessfulCopyWithImpl<SmsListSuccessful>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsListSuccessful&&(identical(other.sms, sms) || other.sms == sms)&&(identical(other.loadedPage, loadedPage) || other.loadedPage == loadedPage)&&(identical(other.totalPage, totalPage) || other.totalPage == totalPage));
}


@override
int get hashCode => Object.hash(runtimeType,sms,loadedPage,totalPage);

@override
String toString() {
  return 'SmsState.smsListSuccessful(sms: $sms, loadedPage: $loadedPage, totalPage: $totalPage)';
}


}

/// @nodoc
abstract mixin class $SmsListSuccessfulCopyWith<$Res> implements $SmsStateCopyWith<$Res> {
  factory $SmsListSuccessfulCopyWith(SmsListSuccessful value, $Res Function(SmsListSuccessful) _then) = _$SmsListSuccessfulCopyWithImpl;
@useResult
$Res call({
 SmsApiEntity sms, int loadedPage, int totalPage
});




}
/// @nodoc
class _$SmsListSuccessfulCopyWithImpl<$Res>
    implements $SmsListSuccessfulCopyWith<$Res> {
  _$SmsListSuccessfulCopyWithImpl(this._self, this._then);

  final SmsListSuccessful _self;
  final $Res Function(SmsListSuccessful) _then;

/// Create a copy of SmsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sms = null,Object? loadedPage = null,Object? totalPage = null,}) {
  return _then(SmsListSuccessful(
sms: null == sms ? _self.sms : sms // ignore: cast_nullable_to_non_nullable
as SmsApiEntity,loadedPage: null == loadedPage ? _self.loadedPage : loadedPage // ignore: cast_nullable_to_non_nullable
as int,totalPage: null == totalPage ? _self.totalPage : totalPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SmsListFailed implements SmsState {
  const SmsListFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsListFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmsState.smsListFailed()';
}


}




// dart format on
