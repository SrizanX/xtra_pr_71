// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get isStaySignedInChecked => throw _privateConstructorUsedError;
  LoginApiState get loginApiState => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {String username,
      String password,
      bool isStaySignedInChecked,
      LoginApiState loginApiState});

  $LoginApiStateCopyWith<$Res> get loginApiState;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? isStaySignedInChecked = null,
    Object? loginApiState = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isStaySignedInChecked: null == isStaySignedInChecked
          ? _value.isStaySignedInChecked
          : isStaySignedInChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      loginApiState: null == loginApiState
          ? _value.loginApiState
          : loginApiState // ignore: cast_nullable_to_non_nullable
              as LoginApiState,
    ) as $Val);
  }

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginApiStateCopyWith<$Res> get loginApiState {
    return $LoginApiStateCopyWith<$Res>(_value.loginApiState, (value) {
      return _then(_value.copyWith(loginApiState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String password,
      bool isStaySignedInChecked,
      LoginApiState loginApiState});

  @override
  $LoginApiStateCopyWith<$Res> get loginApiState;
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? isStaySignedInChecked = null,
    Object? loginApiState = null,
  }) {
    return _then(_$LoginStateImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isStaySignedInChecked: null == isStaySignedInChecked
          ? _value.isStaySignedInChecked
          : isStaySignedInChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      loginApiState: null == loginApiState
          ? _value.loginApiState
          : loginApiState // ignore: cast_nullable_to_non_nullable
              as LoginApiState,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl(
      {this.username = "admin",
      this.password = "admin",
      this.isStaySignedInChecked = false,
      this.loginApiState = const LoginApiState.initial()});

  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool isStaySignedInChecked;
  @override
  @JsonKey()
  final LoginApiState loginApiState;

  @override
  String toString() {
    return 'LoginState(username: $username, password: $password, isStaySignedInChecked: $isStaySignedInChecked, loginApiState: $loginApiState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isStaySignedInChecked, isStaySignedInChecked) ||
                other.isStaySignedInChecked == isStaySignedInChecked) &&
            (identical(other.loginApiState, loginApiState) ||
                other.loginApiState == loginApiState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, username, password, isStaySignedInChecked, loginApiState);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final String username,
      final String password,
      final bool isStaySignedInChecked,
      final LoginApiState loginApiState}) = _$LoginStateImpl;

  @override
  String get username;
  @override
  String get password;
  @override
  bool get isStaySignedInChecked;
  @override
  LoginApiState get loginApiState;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginApiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginInProgress,
    required TResult Function() loginSuccessful,
    required TResult Function(String message) loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginInProgress,
    TResult? Function()? loginSuccessful,
    TResult? Function(String message)? loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginInProgress,
    TResult Function()? loginSuccessful,
    TResult Function(String message)? loginFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(LoginSuccessful value) loginSuccessful,
    required TResult Function(LoginFailed value) loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(LoginSuccessful value)? loginSuccessful,
    TResult? Function(LoginFailed value)? loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(LoginSuccessful value)? loginSuccessful,
    TResult Function(LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginApiStateCopyWith<$Res> {
  factory $LoginApiStateCopyWith(
          LoginApiState value, $Res Function(LoginApiState) then) =
      _$LoginApiStateCopyWithImpl<$Res, LoginApiState>;
}

/// @nodoc
class _$LoginApiStateCopyWithImpl<$Res, $Val extends LoginApiState>
    implements $LoginApiStateCopyWith<$Res> {
  _$LoginApiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginApiState
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
    extends _$LoginApiStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'LoginApiState.initial()';
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
    required TResult Function() loginInProgress,
    required TResult Function() loginSuccessful,
    required TResult Function(String message) loginFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginInProgress,
    TResult? Function()? loginSuccessful,
    TResult? Function(String message)? loginFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginInProgress,
    TResult Function()? loginSuccessful,
    TResult Function(String message)? loginFailed,
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
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(LoginSuccessful value) loginSuccessful,
    required TResult Function(LoginFailed value) loginFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(LoginSuccessful value)? loginSuccessful,
    TResult? Function(LoginFailed value)? loginFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(LoginSuccessful value)? loginSuccessful,
    TResult Function(LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements LoginApiState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoginInProgressImplCopyWith<$Res> {
  factory _$$LoginInProgressImplCopyWith(_$LoginInProgressImpl value,
          $Res Function(_$LoginInProgressImpl) then) =
      __$$LoginInProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginInProgressImplCopyWithImpl<$Res>
    extends _$LoginApiStateCopyWithImpl<$Res, _$LoginInProgressImpl>
    implements _$$LoginInProgressImplCopyWith<$Res> {
  __$$LoginInProgressImplCopyWithImpl(
      _$LoginInProgressImpl _value, $Res Function(_$LoginInProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginInProgressImpl implements LoginInProgress {
  const _$LoginInProgressImpl();

  @override
  String toString() {
    return 'LoginApiState.loginInProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginInProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginInProgress,
    required TResult Function() loginSuccessful,
    required TResult Function(String message) loginFailed,
  }) {
    return loginInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginInProgress,
    TResult? Function()? loginSuccessful,
    TResult? Function(String message)? loginFailed,
  }) {
    return loginInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginInProgress,
    TResult Function()? loginSuccessful,
    TResult Function(String message)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginInProgress != null) {
      return loginInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(LoginSuccessful value) loginSuccessful,
    required TResult Function(LoginFailed value) loginFailed,
  }) {
    return loginInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(LoginSuccessful value)? loginSuccessful,
    TResult? Function(LoginFailed value)? loginFailed,
  }) {
    return loginInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(LoginSuccessful value)? loginSuccessful,
    TResult Function(LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginInProgress != null) {
      return loginInProgress(this);
    }
    return orElse();
  }
}

abstract class LoginInProgress implements LoginApiState {
  const factory LoginInProgress() = _$LoginInProgressImpl;
}

/// @nodoc
abstract class _$$LoginSuccessfulImplCopyWith<$Res> {
  factory _$$LoginSuccessfulImplCopyWith(_$LoginSuccessfulImpl value,
          $Res Function(_$LoginSuccessfulImpl) then) =
      __$$LoginSuccessfulImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSuccessfulImplCopyWithImpl<$Res>
    extends _$LoginApiStateCopyWithImpl<$Res, _$LoginSuccessfulImpl>
    implements _$$LoginSuccessfulImplCopyWith<$Res> {
  __$$LoginSuccessfulImplCopyWithImpl(
      _$LoginSuccessfulImpl _value, $Res Function(_$LoginSuccessfulImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSuccessfulImpl implements LoginSuccessful {
  const _$LoginSuccessfulImpl();

  @override
  String toString() {
    return 'LoginApiState.loginSuccessful()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSuccessfulImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginInProgress,
    required TResult Function() loginSuccessful,
    required TResult Function(String message) loginFailed,
  }) {
    return loginSuccessful();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginInProgress,
    TResult? Function()? loginSuccessful,
    TResult? Function(String message)? loginFailed,
  }) {
    return loginSuccessful?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginInProgress,
    TResult Function()? loginSuccessful,
    TResult Function(String message)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginSuccessful != null) {
      return loginSuccessful();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(LoginSuccessful value) loginSuccessful,
    required TResult Function(LoginFailed value) loginFailed,
  }) {
    return loginSuccessful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(LoginSuccessful value)? loginSuccessful,
    TResult? Function(LoginFailed value)? loginFailed,
  }) {
    return loginSuccessful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(LoginSuccessful value)? loginSuccessful,
    TResult Function(LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginSuccessful != null) {
      return loginSuccessful(this);
    }
    return orElse();
  }
}

abstract class LoginSuccessful implements LoginApiState {
  const factory LoginSuccessful() = _$LoginSuccessfulImpl;
}

/// @nodoc
abstract class _$$LoginFailedImplCopyWith<$Res> {
  factory _$$LoginFailedImplCopyWith(
          _$LoginFailedImpl value, $Res Function(_$LoginFailedImpl) then) =
      __$$LoginFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LoginFailedImplCopyWithImpl<$Res>
    extends _$LoginApiStateCopyWithImpl<$Res, _$LoginFailedImpl>
    implements _$$LoginFailedImplCopyWith<$Res> {
  __$$LoginFailedImplCopyWithImpl(
      _$LoginFailedImpl _value, $Res Function(_$LoginFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$LoginFailedImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginFailedImpl implements LoginFailed {
  const _$LoginFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'LoginApiState.loginFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFailedImplCopyWith<_$LoginFailedImpl> get copyWith =>
      __$$LoginFailedImplCopyWithImpl<_$LoginFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginInProgress,
    required TResult Function() loginSuccessful,
    required TResult Function(String message) loginFailed,
  }) {
    return loginFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginInProgress,
    TResult? Function()? loginSuccessful,
    TResult? Function(String message)? loginFailed,
  }) {
    return loginFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginInProgress,
    TResult Function()? loginSuccessful,
    TResult Function(String message)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginFailed != null) {
      return loginFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(LoginSuccessful value) loginSuccessful,
    required TResult Function(LoginFailed value) loginFailed,
  }) {
    return loginFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(LoginSuccessful value)? loginSuccessful,
    TResult? Function(LoginFailed value)? loginFailed,
  }) {
    return loginFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(LoginSuccessful value)? loginSuccessful,
    TResult Function(LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginFailed != null) {
      return loginFailed(this);
    }
    return orElse();
  }
}

abstract class LoginFailed implements LoginApiState {
  const factory LoginFailed({required final String message}) =
      _$LoginFailedImpl;

  String get message;

  /// Create a copy of LoginApiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginFailedImplCopyWith<_$LoginFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
