// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageStateData value) $default, {
    required TResult Function(MessageStateLoading value) loading,
    required TResult Function(MessageStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageStateData value)? $default, {
    TResult? Function(MessageStateLoading value)? loading,
    TResult? Function(MessageStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageStateData value)? $default, {
    TResult Function(MessageStateLoading value)? loading,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) then) =
      _$MessageStateCopyWithImpl<$Res, MessageState>;
}

/// @nodoc
class _$MessageStateCopyWithImpl<$Res, $Val extends MessageState>
    implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MessageStateDataImplCopyWith<$Res> {
  factory _$$MessageStateDataImplCopyWith(_$MessageStateDataImpl value,
          $Res Function(_$MessageStateDataImpl) then) =
      __$$MessageStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MessageEntity data, File? mediaFile, bool mediaLoading});
}

/// @nodoc
class __$$MessageStateDataImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$MessageStateDataImpl>
    implements _$$MessageStateDataImplCopyWith<$Res> {
  __$$MessageStateDataImplCopyWithImpl(_$MessageStateDataImpl _value,
      $Res Function(_$MessageStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? mediaFile = freezed,
    Object? mediaLoading = null,
  }) {
    return _then(_$MessageStateDataImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MessageEntity,
      mediaFile: freezed == mediaFile
          ? _value.mediaFile
          : mediaFile // ignore: cast_nullable_to_non_nullable
              as File?,
      mediaLoading: null == mediaLoading
          ? _value.mediaLoading
          : mediaLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MessageStateDataImpl implements MessageStateData {
  const _$MessageStateDataImpl(this.data,
      {this.mediaFile, required this.mediaLoading});

  @override
  final MessageEntity data;
  @override
  final File? mediaFile;
  @override
  final bool mediaLoading;

  @override
  String toString() {
    return 'MessageState(data: $data, mediaFile: $mediaFile, mediaLoading: $mediaLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageStateDataImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.mediaFile, mediaFile) ||
                other.mediaFile == mediaFile) &&
            (identical(other.mediaLoading, mediaLoading) ||
                other.mediaLoading == mediaLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, mediaFile, mediaLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageStateDataImplCopyWith<_$MessageStateDataImpl> get copyWith =>
      __$$MessageStateDataImplCopyWithImpl<_$MessageStateDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return $default(data, mediaFile, mediaLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return $default?.call(data, mediaFile, mediaLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(data, mediaFile, mediaLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageStateData value) $default, {
    required TResult Function(MessageStateLoading value) loading,
    required TResult Function(MessageStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageStateData value)? $default, {
    TResult? Function(MessageStateLoading value)? loading,
    TResult? Function(MessageStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageStateData value)? $default, {
    TResult Function(MessageStateLoading value)? loading,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class MessageStateData implements MessageState {
  const factory MessageStateData(final MessageEntity data,
      {final File? mediaFile,
      required final bool mediaLoading}) = _$MessageStateDataImpl;

  MessageEntity get data;
  File? get mediaFile;
  bool get mediaLoading;
  @JsonKey(ignore: true)
  _$$MessageStateDataImplCopyWith<_$MessageStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageStateLoadingImplCopyWith<$Res> {
  factory _$$MessageStateLoadingImplCopyWith(_$MessageStateLoadingImpl value,
          $Res Function(_$MessageStateLoadingImpl) then) =
      __$$MessageStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MessageStateLoadingImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$MessageStateLoadingImpl>
    implements _$$MessageStateLoadingImplCopyWith<$Res> {
  __$$MessageStateLoadingImplCopyWithImpl(_$MessageStateLoadingImpl _value,
      $Res Function(_$MessageStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MessageStateLoadingImpl implements MessageStateLoading {
  const _$MessageStateLoadingImpl();

  @override
  String toString() {
    return 'MessageState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
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
    TResult Function(MessageStateData value) $default, {
    required TResult Function(MessageStateLoading value) loading,
    required TResult Function(MessageStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageStateData value)? $default, {
    TResult? Function(MessageStateLoading value)? loading,
    TResult? Function(MessageStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageStateData value)? $default, {
    TResult Function(MessageStateLoading value)? loading,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MessageStateLoading implements MessageState {
  const factory MessageStateLoading() = _$MessageStateLoadingImpl;
}

/// @nodoc
abstract class _$$MessageStateErrorImplCopyWith<$Res> {
  factory _$$MessageStateErrorImplCopyWith(_$MessageStateErrorImpl value,
          $Res Function(_$MessageStateErrorImpl) then) =
      __$$MessageStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$MessageStateErrorImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$MessageStateErrorImpl>
    implements _$$MessageStateErrorImplCopyWith<$Res> {
  __$$MessageStateErrorImplCopyWithImpl(_$MessageStateErrorImpl _value,
      $Res Function(_$MessageStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$MessageStateErrorImpl(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$MessageStateErrorImpl implements MessageStateError {
  const _$MessageStateErrorImpl(this.error);

  @override
  final dynamic error;

  @override
  String toString() {
    return 'MessageState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageStateErrorImplCopyWith<_$MessageStateErrorImpl> get copyWith =>
      __$$MessageStateErrorImplCopyWithImpl<_$MessageStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(MessageEntity data, File? mediaFile, bool mediaLoading)?
        $default, {
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
    TResult Function(MessageStateData value) $default, {
    required TResult Function(MessageStateLoading value) loading,
    required TResult Function(MessageStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageStateData value)? $default, {
    TResult? Function(MessageStateLoading value)? loading,
    TResult? Function(MessageStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageStateData value)? $default, {
    TResult Function(MessageStateLoading value)? loading,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MessageStateError implements MessageState {
  const factory MessageStateError(final dynamic error) =
      _$MessageStateErrorImpl;

  dynamic get error;
  @JsonKey(ignore: true)
  _$$MessageStateErrorImplCopyWith<_$MessageStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
