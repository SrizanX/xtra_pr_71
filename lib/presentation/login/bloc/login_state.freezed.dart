// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 String get username; String get password; bool get isStaySignedInChecked; LoginApiState get loginApiState;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.isStaySignedInChecked, isStaySignedInChecked) || other.isStaySignedInChecked == isStaySignedInChecked)&&(identical(other.loginApiState, loginApiState) || other.loginApiState == loginApiState));
}


@override
int get hashCode => Object.hash(runtimeType,username,password,isStaySignedInChecked,loginApiState);

@override
String toString() {
  return 'LoginState(username: $username, password: $password, isStaySignedInChecked: $isStaySignedInChecked, loginApiState: $loginApiState)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 String username, String password, bool isStaySignedInChecked, LoginApiState loginApiState
});


$LoginApiStateCopyWith<$Res> get loginApiState;

}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,Object? isStaySignedInChecked = null,Object? loginApiState = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isStaySignedInChecked: null == isStaySignedInChecked ? _self.isStaySignedInChecked : isStaySignedInChecked // ignore: cast_nullable_to_non_nullable
as bool,loginApiState: null == loginApiState ? _self.loginApiState : loginApiState // ignore: cast_nullable_to_non_nullable
as LoginApiState,
  ));
}
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginApiStateCopyWith<$Res> get loginApiState {
  
  return $LoginApiStateCopyWith<$Res>(_self.loginApiState, (value) {
    return _then(_self.copyWith(loginApiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String password,  bool isStaySignedInChecked,  LoginApiState loginApiState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.username,_that.password,_that.isStaySignedInChecked,_that.loginApiState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String password,  bool isStaySignedInChecked,  LoginApiState loginApiState)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.username,_that.password,_that.isStaySignedInChecked,_that.loginApiState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String password,  bool isStaySignedInChecked,  LoginApiState loginApiState)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.username,_that.password,_that.isStaySignedInChecked,_that.loginApiState);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({this.username = "admin", this.password = "admin", this.isStaySignedInChecked = false, this.loginApiState = const LoginApiState.initial()});
  

@override@JsonKey() final  String username;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool isStaySignedInChecked;
@override@JsonKey() final  LoginApiState loginApiState;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.isStaySignedInChecked, isStaySignedInChecked) || other.isStaySignedInChecked == isStaySignedInChecked)&&(identical(other.loginApiState, loginApiState) || other.loginApiState == loginApiState));
}


@override
int get hashCode => Object.hash(runtimeType,username,password,isStaySignedInChecked,loginApiState);

@override
String toString() {
  return 'LoginState(username: $username, password: $password, isStaySignedInChecked: $isStaySignedInChecked, loginApiState: $loginApiState)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 String username, String password, bool isStaySignedInChecked, LoginApiState loginApiState
});


@override $LoginApiStateCopyWith<$Res> get loginApiState;

}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,Object? isStaySignedInChecked = null,Object? loginApiState = null,}) {
  return _then(_LoginState(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isStaySignedInChecked: null == isStaySignedInChecked ? _self.isStaySignedInChecked : isStaySignedInChecked // ignore: cast_nullable_to_non_nullable
as bool,loginApiState: null == loginApiState ? _self.loginApiState : loginApiState // ignore: cast_nullable_to_non_nullable
as LoginApiState,
  ));
}

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginApiStateCopyWith<$Res> get loginApiState {
  
  return $LoginApiStateCopyWith<$Res>(_self.loginApiState, (value) {
    return _then(_self.copyWith(loginApiState: value));
  });
}
}

/// @nodoc
mixin _$LoginApiState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginApiState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginApiState()';
}


}

/// @nodoc
class $LoginApiStateCopyWith<$Res>  {
$LoginApiStateCopyWith(LoginApiState _, $Res Function(LoginApiState) __);
}


/// Adds pattern-matching-related methods to [LoginApiState].
extension LoginApiStatePatterns on LoginApiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( LoginInProgress value)?  loginInProgress,TResult Function( LoginSuccessful value)?  loginSuccessful,TResult Function( LoginFailed value)?  loginFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoginInProgress() when loginInProgress != null:
return loginInProgress(_that);case LoginSuccessful() when loginSuccessful != null:
return loginSuccessful(_that);case LoginFailed() when loginFailed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( LoginInProgress value)  loginInProgress,required TResult Function( LoginSuccessful value)  loginSuccessful,required TResult Function( LoginFailed value)  loginFailed,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case LoginInProgress():
return loginInProgress(_that);case LoginSuccessful():
return loginSuccessful(_that);case LoginFailed():
return loginFailed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( LoginInProgress value)?  loginInProgress,TResult? Function( LoginSuccessful value)?  loginSuccessful,TResult? Function( LoginFailed value)?  loginFailed,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case LoginInProgress() when loginInProgress != null:
return loginInProgress(_that);case LoginSuccessful() when loginSuccessful != null:
return loginSuccessful(_that);case LoginFailed() when loginFailed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loginInProgress,TResult Function()?  loginSuccessful,TResult Function( String message)?  loginFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoginInProgress() when loginInProgress != null:
return loginInProgress();case LoginSuccessful() when loginSuccessful != null:
return loginSuccessful();case LoginFailed() when loginFailed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loginInProgress,required TResult Function()  loginSuccessful,required TResult Function( String message)  loginFailed,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case LoginInProgress():
return loginInProgress();case LoginSuccessful():
return loginSuccessful();case LoginFailed():
return loginFailed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loginInProgress,TResult? Function()?  loginSuccessful,TResult? Function( String message)?  loginFailed,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case LoginInProgress() when loginInProgress != null:
return loginInProgress();case LoginSuccessful() when loginSuccessful != null:
return loginSuccessful();case LoginFailed() when loginFailed != null:
return loginFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements LoginApiState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginApiState.initial()';
}


}




/// @nodoc


class LoginInProgress implements LoginApiState {
  const LoginInProgress();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginInProgress);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginApiState.loginInProgress()';
}


}




/// @nodoc


class LoginSuccessful implements LoginApiState {
  const LoginSuccessful();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSuccessful);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginApiState.loginSuccessful()';
}


}




/// @nodoc


class LoginFailed implements LoginApiState {
  const LoginFailed({required this.message});
  

 final  String message;

/// Create a copy of LoginApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFailedCopyWith<LoginFailed> get copyWith => _$LoginFailedCopyWithImpl<LoginFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginApiState.loginFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $LoginFailedCopyWith<$Res> implements $LoginApiStateCopyWith<$Res> {
  factory $LoginFailedCopyWith(LoginFailed value, $Res Function(LoginFailed) _then) = _$LoginFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LoginFailedCopyWithImpl<$Res>
    implements $LoginFailedCopyWith<$Res> {
  _$LoginFailedCopyWithImpl(this._self, this._then);

  final LoginFailed _self;
  final $Res Function(LoginFailed) _then;

/// Create a copy of LoginApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LoginFailed(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
