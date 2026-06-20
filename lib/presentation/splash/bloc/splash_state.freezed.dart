// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplashState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState()';
}


}

/// @nodoc
class $SplashStateCopyWith<$Res>  {
$SplashStateCopyWith(SplashState _, $Res Function(SplashState) __);
}


/// Adds pattern-matching-related methods to [SplashState].
extension SplashStatePatterns on SplashState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( LoginSuccessfulFromSplash value)?  loginSuccessful,TResult Function( LoginFailedFromSplash value)?  loginFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoginSuccessfulFromSplash() when loginSuccessful != null:
return loginSuccessful(_that);case LoginFailedFromSplash() when loginFailed != null:
return loginFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( LoginSuccessfulFromSplash value)  loginSuccessful,required TResult Function( LoginFailedFromSplash value)  loginFailed,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case LoginSuccessfulFromSplash():
return loginSuccessful(_that);case LoginFailedFromSplash():
return loginFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( LoginSuccessfulFromSplash value)?  loginSuccessful,TResult? Function( LoginFailedFromSplash value)?  loginFailed,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoginSuccessfulFromSplash() when loginSuccessful != null:
return loginSuccessful(_that);case LoginFailedFromSplash() when loginFailed != null:
return loginFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loginSuccessful,TResult Function( String message)?  loginFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoginSuccessfulFromSplash() when loginSuccessful != null:
return loginSuccessful();case LoginFailedFromSplash() when loginFailed != null:
return loginFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loginSuccessful,required TResult Function( String message)  loginFailed,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case LoginSuccessfulFromSplash():
return loginSuccessful();case LoginFailedFromSplash():
return loginFailed(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loginSuccessful,TResult? Function( String message)?  loginFailed,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoginSuccessfulFromSplash() when loginSuccessful != null:
return loginSuccessful();case LoginFailedFromSplash() when loginFailed != null:
return loginFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements SplashState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.initial()';
}


}




/// @nodoc


class LoginSuccessfulFromSplash implements SplashState {
  const LoginSuccessfulFromSplash();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSuccessfulFromSplash);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.loginSuccessful()';
}


}




/// @nodoc


class LoginFailedFromSplash implements SplashState {
  const LoginFailedFromSplash({required this.message});
  

 final  String message;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFailedFromSplashCopyWith<LoginFailedFromSplash> get copyWith => _$LoginFailedFromSplashCopyWithImpl<LoginFailedFromSplash>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFailedFromSplash&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SplashState.loginFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $LoginFailedFromSplashCopyWith<$Res> implements $SplashStateCopyWith<$Res> {
  factory $LoginFailedFromSplashCopyWith(LoginFailedFromSplash value, $Res Function(LoginFailedFromSplash) _then) = _$LoginFailedFromSplashCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LoginFailedFromSplashCopyWithImpl<$Res>
    implements $LoginFailedFromSplashCopyWith<$Res> {
  _$LoginFailedFromSplashCopyWithImpl(this._self, this._then);

  final LoginFailedFromSplash _self;
  final $Res Function(LoginFailedFromSplash) _then;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LoginFailedFromSplash(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
