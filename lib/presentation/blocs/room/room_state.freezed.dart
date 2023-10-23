// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RoomState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<RoomEntity> rooms)? $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms)? $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RoomStateData value) $default, {
    required TResult Function(RoomStateLoading value) loading,
    required TResult Function(RoomStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RoomStateData value)? $default, {
    TResult? Function(RoomStateLoading value)? loading,
    TResult? Function(RoomStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RoomStateData value)? $default, {
    TResult Function(RoomStateLoading value)? loading,
    TResult Function(RoomStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomStateCopyWith<$Res> {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) then) =
      _$RoomStateCopyWithImpl<$Res, RoomState>;
}

/// @nodoc
class _$RoomStateCopyWithImpl<$Res, $Val extends RoomState>
    implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RoomStateDataImplCopyWith<$Res> {
  factory _$$RoomStateDataImplCopyWith(
          _$RoomStateDataImpl value, $Res Function(_$RoomStateDataImpl) then) =
      __$$RoomStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RoomEntity> rooms});
}

/// @nodoc
class __$$RoomStateDataImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomStateDataImpl>
    implements _$$RoomStateDataImplCopyWith<$Res> {
  __$$RoomStateDataImplCopyWithImpl(
      _$RoomStateDataImpl _value, $Res Function(_$RoomStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rooms = null,
  }) {
    return _then(_$RoomStateDataImpl(
      null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<RoomEntity>,
    ));
  }
}

/// @nodoc

class _$RoomStateDataImpl implements RoomStateData {
  const _$RoomStateDataImpl(final List<RoomEntity> rooms) : _rooms = rooms;

  final List<RoomEntity> _rooms;
  @override
  List<RoomEntity> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'RoomState(rooms: $rooms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomStateDataImpl &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rooms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomStateDataImplCopyWith<_$RoomStateDataImpl> get copyWith =>
      __$$RoomStateDataImplCopyWithImpl<_$RoomStateDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return $default(rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<RoomEntity> rooms)? $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return $default?.call(rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms)? $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RoomStateData value) $default, {
    required TResult Function(RoomStateLoading value) loading,
    required TResult Function(RoomStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RoomStateData value)? $default, {
    TResult? Function(RoomStateLoading value)? loading,
    TResult? Function(RoomStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RoomStateData value)? $default, {
    TResult Function(RoomStateLoading value)? loading,
    TResult Function(RoomStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class RoomStateData implements RoomState {
  const factory RoomStateData(final List<RoomEntity> rooms) =
      _$RoomStateDataImpl;

  List<RoomEntity> get rooms;
  @JsonKey(ignore: true)
  _$$RoomStateDataImplCopyWith<_$RoomStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomStateLoadingImplCopyWith<$Res> {
  factory _$$RoomStateLoadingImplCopyWith(_$RoomStateLoadingImpl value,
          $Res Function(_$RoomStateLoadingImpl) then) =
      __$$RoomStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RoomStateLoadingImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomStateLoadingImpl>
    implements _$$RoomStateLoadingImplCopyWith<$Res> {
  __$$RoomStateLoadingImplCopyWithImpl(_$RoomStateLoadingImpl _value,
      $Res Function(_$RoomStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RoomStateLoadingImpl implements RoomStateLoading {
  const _$RoomStateLoadingImpl();

  @override
  String toString() {
    return 'RoomState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RoomStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<RoomEntity> rooms)? $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms)? $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RoomStateData value) $default, {
    required TResult Function(RoomStateLoading value) loading,
    required TResult Function(RoomStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RoomStateData value)? $default, {
    TResult? Function(RoomStateLoading value)? loading,
    TResult? Function(RoomStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RoomStateData value)? $default, {
    TResult Function(RoomStateLoading value)? loading,
    TResult Function(RoomStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RoomStateLoading implements RoomState {
  const factory RoomStateLoading() = _$RoomStateLoadingImpl;
}

/// @nodoc
abstract class _$$RoomStateErrorImplCopyWith<$Res> {
  factory _$$RoomStateErrorImplCopyWith(_$RoomStateErrorImpl value,
          $Res Function(_$RoomStateErrorImpl) then) =
      __$$RoomStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$RoomStateErrorImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomStateErrorImpl>
    implements _$$RoomStateErrorImplCopyWith<$Res> {
  __$$RoomStateErrorImplCopyWithImpl(
      _$RoomStateErrorImpl _value, $Res Function(_$RoomStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$RoomStateErrorImpl(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$RoomStateErrorImpl implements RoomStateError {
  const _$RoomStateErrorImpl(this.error);

  @override
  final dynamic error;

  @override
  String toString() {
    return 'RoomState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomStateErrorImplCopyWith<_$RoomStateErrorImpl> get copyWith =>
      __$$RoomStateErrorImplCopyWithImpl<_$RoomStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<RoomEntity> rooms)? $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<RoomEntity> rooms)? $default, {
    TResult Function()? loading,
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
  TResult map<TResult extends Object?>(
    TResult Function(RoomStateData value) $default, {
    required TResult Function(RoomStateLoading value) loading,
    required TResult Function(RoomStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RoomStateData value)? $default, {
    TResult? Function(RoomStateLoading value)? loading,
    TResult? Function(RoomStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RoomStateData value)? $default, {
    TResult Function(RoomStateLoading value)? loading,
    TResult Function(RoomStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RoomStateError implements RoomState {
  const factory RoomStateError(final dynamic error) = _$RoomStateErrorImpl;

  dynamic get error;
  @JsonKey(ignore: true)
  _$$RoomStateErrorImplCopyWith<_$RoomStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
