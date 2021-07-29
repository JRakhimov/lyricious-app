// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  _AppState call(
      {bool isSpotifyConnected = false, PlayerState? spotifyPlayerStatus}) {
    return _AppState(
      isSpotifyConnected: isSpotifyConnected,
      spotifyPlayerStatus: spotifyPlayerStatus,
    );
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  bool get isSpotifyConnected => throw _privateConstructorUsedError;
  PlayerState? get spotifyPlayerStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call({bool isSpotifyConnected, PlayerState? spotifyPlayerStatus});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object? isSpotifyConnected = freezed,
    Object? spotifyPlayerStatus = freezed,
  }) {
    return _then(_value.copyWith(
      isSpotifyConnected: isSpotifyConnected == freezed
          ? _value.isSpotifyConnected
          : isSpotifyConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyPlayerStatus: spotifyPlayerStatus == freezed
          ? _value.spotifyPlayerStatus
          : spotifyPlayerStatus // ignore: cast_nullable_to_non_nullable
              as PlayerState?,
    ));
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isSpotifyConnected, PlayerState? spotifyPlayerStatus});
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(_AppState _value, $Res Function(_AppState) _then)
      : super(_value, (v) => _then(v as _AppState));

  @override
  _AppState get _value => super._value as _AppState;

  @override
  $Res call({
    Object? isSpotifyConnected = freezed,
    Object? spotifyPlayerStatus = freezed,
  }) {
    return _then(_AppState(
      isSpotifyConnected: isSpotifyConnected == freezed
          ? _value.isSpotifyConnected
          : isSpotifyConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyPlayerStatus: spotifyPlayerStatus == freezed
          ? _value.spotifyPlayerStatus
          : spotifyPlayerStatus // ignore: cast_nullable_to_non_nullable
              as PlayerState?,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  const _$_AppState(
      {this.isSpotifyConnected = false, this.spotifyPlayerStatus});

  @JsonKey(defaultValue: false)
  @override
  final bool isSpotifyConnected;
  @override
  final PlayerState? spotifyPlayerStatus;

  @override
  String toString() {
    return 'AppState(isSpotifyConnected: $isSpotifyConnected, spotifyPlayerStatus: $spotifyPlayerStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.isSpotifyConnected, isSpotifyConnected) ||
                const DeepCollectionEquality()
                    .equals(other.isSpotifyConnected, isSpotifyConnected)) &&
            (identical(other.spotifyPlayerStatus, spotifyPlayerStatus) ||
                const DeepCollectionEquality()
                    .equals(other.spotifyPlayerStatus, spotifyPlayerStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isSpotifyConnected) ^
      const DeepCollectionEquality().hash(spotifyPlayerStatus);

  @JsonKey(ignore: true)
  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {bool isSpotifyConnected,
      PlayerState? spotifyPlayerStatus}) = _$_AppState;

  @override
  bool get isSpotifyConnected => throw _privateConstructorUsedError;
  @override
  PlayerState? get spotifyPlayerStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppStateCopyWith<_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
