// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(UserEntity userEntity) authenticated,
    required TResult Function() unAuthenticated,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(UserEntity userEntity)? authenticated,
    TResult? Function()? unAuthenticated,
    TResult? Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(UserEntity userEntity)? authenticated,
    TResult Function()? unAuthenticated,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateWaiting value) waiting,
    required TResult Function(_AuthStateAuthenticated value) authenticated,
    required TResult Function(_AuthStateUnAuthenticated value) unAuthenticated,
    required TResult Function(_AuthStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateWaiting value)? waiting,
    TResult? Function(_AuthStateAuthenticated value)? authenticated,
    TResult? Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult? Function(_AuthStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateWaiting value)? waiting,
    TResult Function(_AuthStateAuthenticated value)? authenticated,
    TResult Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AuthStateWaitingCopyWith<$Res> {
  factory _$$_AuthStateWaitingCopyWith(
          _$_AuthStateWaiting value, $Res Function(_$_AuthStateWaiting) then) =
      __$$_AuthStateWaitingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthStateWaitingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateWaiting>
    implements _$$_AuthStateWaitingCopyWith<$Res> {
  __$$_AuthStateWaitingCopyWithImpl(
      _$_AuthStateWaiting _value, $Res Function(_$_AuthStateWaiting) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthStateWaiting
    with DiagnosticableTreeMixin
    implements _AuthStateWaiting {
  const _$_AuthStateWaiting();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.waiting()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.waiting'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthStateWaiting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(UserEntity userEntity) authenticated,
    required TResult Function() unAuthenticated,
    required TResult Function(dynamic error) error,
  }) {
    return waiting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(UserEntity userEntity)? authenticated,
    TResult? Function()? unAuthenticated,
    TResult? Function(dynamic error)? error,
  }) {
    return waiting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(UserEntity userEntity)? authenticated,
    TResult Function()? unAuthenticated,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (waiting != null) {
      return waiting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateWaiting value) waiting,
    required TResult Function(_AuthStateAuthenticated value) authenticated,
    required TResult Function(_AuthStateUnAuthenticated value) unAuthenticated,
    required TResult Function(_AuthStateError value) error,
  }) {
    return waiting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateWaiting value)? waiting,
    TResult? Function(_AuthStateAuthenticated value)? authenticated,
    TResult? Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult? Function(_AuthStateError value)? error,
  }) {
    return waiting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateWaiting value)? waiting,
    TResult Function(_AuthStateAuthenticated value)? authenticated,
    TResult Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (waiting != null) {
      return waiting(this);
    }
    return orElse();
  }
}

abstract class _AuthStateWaiting implements AuthState {
  const factory _AuthStateWaiting() = _$_AuthStateWaiting;
}

/// @nodoc
abstract class _$$_AuthStateAuthenticatedCopyWith<$Res> {
  factory _$$_AuthStateAuthenticatedCopyWith(_$_AuthStateAuthenticated value,
          $Res Function(_$_AuthStateAuthenticated) then) =
      __$$_AuthStateAuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity userEntity});

  $UserEntityCopyWith<$Res> get userEntity;
}

/// @nodoc
class __$$_AuthStateAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateAuthenticated>
    implements _$$_AuthStateAuthenticatedCopyWith<$Res> {
  __$$_AuthStateAuthenticatedCopyWithImpl(_$_AuthStateAuthenticated _value,
      $Res Function(_$_AuthStateAuthenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEntity = null,
  }) {
    return _then(_$_AuthStateAuthenticated(
      null == userEntity
          ? _value.userEntity
          : userEntity // ignore: cast_nullable_to_non_nullable
              as UserEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get userEntity {
    return $UserEntityCopyWith<$Res>(_value.userEntity, (value) {
      return _then(_value.copyWith(userEntity: value));
    });
  }
}

/// @nodoc

class _$_AuthStateAuthenticated
    with DiagnosticableTreeMixin
    implements _AuthStateAuthenticated {
  const _$_AuthStateAuthenticated(this.userEntity);

  @override
  final UserEntity userEntity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticated(userEntity: $userEntity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.authenticated'))
      ..add(DiagnosticsProperty('userEntity', userEntity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateAuthenticated &&
            (identical(other.userEntity, userEntity) ||
                other.userEntity == userEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateAuthenticatedCopyWith<_$_AuthStateAuthenticated> get copyWith =>
      __$$_AuthStateAuthenticatedCopyWithImpl<_$_AuthStateAuthenticated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(UserEntity userEntity) authenticated,
    required TResult Function() unAuthenticated,
    required TResult Function(dynamic error) error,
  }) {
    return authenticated(userEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(UserEntity userEntity)? authenticated,
    TResult? Function()? unAuthenticated,
    TResult? Function(dynamic error)? error,
  }) {
    return authenticated?.call(userEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(UserEntity userEntity)? authenticated,
    TResult Function()? unAuthenticated,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateWaiting value) waiting,
    required TResult Function(_AuthStateAuthenticated value) authenticated,
    required TResult Function(_AuthStateUnAuthenticated value) unAuthenticated,
    required TResult Function(_AuthStateError value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateWaiting value)? waiting,
    TResult? Function(_AuthStateAuthenticated value)? authenticated,
    TResult? Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult? Function(_AuthStateError value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateWaiting value)? waiting,
    TResult Function(_AuthStateAuthenticated value)? authenticated,
    TResult Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthStateAuthenticated implements AuthState {
  const factory _AuthStateAuthenticated(final UserEntity userEntity) =
      _$_AuthStateAuthenticated;

  UserEntity get userEntity;
  @JsonKey(ignore: true)
  _$$_AuthStateAuthenticatedCopyWith<_$_AuthStateAuthenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthStateUnAuthenticatedCopyWith<$Res> {
  factory _$$_AuthStateUnAuthenticatedCopyWith(
          _$_AuthStateUnAuthenticated value,
          $Res Function(_$_AuthStateUnAuthenticated) then) =
      __$$_AuthStateUnAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthStateUnAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateUnAuthenticated>
    implements _$$_AuthStateUnAuthenticatedCopyWith<$Res> {
  __$$_AuthStateUnAuthenticatedCopyWithImpl(_$_AuthStateUnAuthenticated _value,
      $Res Function(_$_AuthStateUnAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthStateUnAuthenticated
    with DiagnosticableTreeMixin
    implements _AuthStateUnAuthenticated {
  const _$_AuthStateUnAuthenticated();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.unAuthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.unAuthenticated'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateUnAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(UserEntity userEntity) authenticated,
    required TResult Function() unAuthenticated,
    required TResult Function(dynamic error) error,
  }) {
    return unAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(UserEntity userEntity)? authenticated,
    TResult? Function()? unAuthenticated,
    TResult? Function(dynamic error)? error,
  }) {
    return unAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(UserEntity userEntity)? authenticated,
    TResult Function()? unAuthenticated,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateWaiting value) waiting,
    required TResult Function(_AuthStateAuthenticated value) authenticated,
    required TResult Function(_AuthStateUnAuthenticated value) unAuthenticated,
    required TResult Function(_AuthStateError value) error,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateWaiting value)? waiting,
    TResult? Function(_AuthStateAuthenticated value)? authenticated,
    TResult? Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult? Function(_AuthStateError value)? error,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateWaiting value)? waiting,
    TResult Function(_AuthStateAuthenticated value)? authenticated,
    TResult Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthStateUnAuthenticated implements AuthState {
  const factory _AuthStateUnAuthenticated() = _$_AuthStateUnAuthenticated;
}

/// @nodoc
abstract class _$$_AuthStateErrorCopyWith<$Res> {
  factory _$$_AuthStateErrorCopyWith(
          _$_AuthStateError value, $Res Function(_$_AuthStateError) then) =
      __$$_AuthStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$_AuthStateErrorCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateError>
    implements _$$_AuthStateErrorCopyWith<$Res> {
  __$$_AuthStateErrorCopyWithImpl(
      _$_AuthStateError _value, $Res Function(_$_AuthStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$_AuthStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_AuthStateError
    with DiagnosticableTreeMixin
    implements _AuthStateError {
  const _$_AuthStateError(this.error);

  @override
  final dynamic error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.error(error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.error'))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      __$$_AuthStateErrorCopyWithImpl<_$_AuthStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(UserEntity userEntity) authenticated,
    required TResult Function() unAuthenticated,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(UserEntity userEntity)? authenticated,
    TResult? Function()? unAuthenticated,
    TResult? Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(UserEntity userEntity)? authenticated,
    TResult Function()? unAuthenticated,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateWaiting value) waiting,
    required TResult Function(_AuthStateAuthenticated value) authenticated,
    required TResult Function(_AuthStateUnAuthenticated value) unAuthenticated,
    required TResult Function(_AuthStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateWaiting value)? waiting,
    TResult? Function(_AuthStateAuthenticated value)? authenticated,
    TResult? Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult? Function(_AuthStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateWaiting value)? waiting,
    TResult Function(_AuthStateAuthenticated value)? authenticated,
    TResult Function(_AuthStateUnAuthenticated value)? unAuthenticated,
    TResult Function(_AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthStateError implements AuthState {
  const factory _AuthStateError(final dynamic error) = _$_AuthStateError;

  dynamic get error;
  @JsonKey(ignore: true)
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
