// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ChatStateData value) $default, {
    required TResult Function(ChatStateLoading value) loading,
    required TResult Function(ChatStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ChatStateData value)? $default, {
    TResult? Function(ChatStateLoading value)? loading,
    TResult? Function(ChatStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ChatStateData value)? $default, {
    TResult Function(ChatStateLoading value)? loading,
    TResult Function(ChatStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatStateDataImplCopyWith<$Res> {
  factory _$$ChatStateDataImplCopyWith(
          _$ChatStateDataImpl value, $Res Function(_$ChatStateDataImpl) then) =
      __$$ChatStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TextEditingController textEditingController,
      MessageDataSource messageDataSource,
      ChatActionStatus chatActionStatus,
      MessageEntity? messageEntity});
}

/// @nodoc
class __$$ChatStateDataImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateDataImpl>
    implements _$$ChatStateDataImplCopyWith<$Res> {
  __$$ChatStateDataImplCopyWithImpl(
      _$ChatStateDataImpl _value, $Res Function(_$ChatStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textEditingController = null,
    Object? messageDataSource = null,
    Object? chatActionStatus = null,
    Object? messageEntity = freezed,
  }) {
    return _then(_$ChatStateDataImpl(
      null == textEditingController
          ? _value.textEditingController
          : textEditingController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      null == messageDataSource
          ? _value.messageDataSource
          : messageDataSource // ignore: cast_nullable_to_non_nullable
              as MessageDataSource,
      null == chatActionStatus
          ? _value.chatActionStatus
          : chatActionStatus // ignore: cast_nullable_to_non_nullable
              as ChatActionStatus,
      messageEntity: freezed == messageEntity
          ? _value.messageEntity
          : messageEntity // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
    ));
  }
}

/// @nodoc

class _$ChatStateDataImpl implements ChatStateData {
  const _$ChatStateDataImpl(
      this.textEditingController, this.messageDataSource, this.chatActionStatus,
      {this.messageEntity});

  @override
  final TextEditingController textEditingController;
  @override
  final MessageDataSource messageDataSource;
  @override
  final ChatActionStatus chatActionStatus;
  @override
  final MessageEntity? messageEntity;

  @override
  String toString() {
    return 'ChatState(textEditingController: $textEditingController, messageDataSource: $messageDataSource, chatActionStatus: $chatActionStatus, messageEntity: $messageEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateDataImpl &&
            (identical(other.textEditingController, textEditingController) ||
                other.textEditingController == textEditingController) &&
            (identical(other.messageDataSource, messageDataSource) ||
                other.messageDataSource == messageDataSource) &&
            (identical(other.chatActionStatus, chatActionStatus) ||
                other.chatActionStatus == chatActionStatus) &&
            (identical(other.messageEntity, messageEntity) ||
                other.messageEntity == messageEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textEditingController,
      messageDataSource, chatActionStatus, messageEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateDataImplCopyWith<_$ChatStateDataImpl> get copyWith =>
      __$$ChatStateDataImplCopyWithImpl<_$ChatStateDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return $default(textEditingController, messageDataSource, chatActionStatus,
        messageEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return $default?.call(textEditingController, messageDataSource,
        chatActionStatus, messageEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(textEditingController, messageDataSource,
          chatActionStatus, messageEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ChatStateData value) $default, {
    required TResult Function(ChatStateLoading value) loading,
    required TResult Function(ChatStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ChatStateData value)? $default, {
    TResult? Function(ChatStateLoading value)? loading,
    TResult? Function(ChatStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ChatStateData value)? $default, {
    TResult Function(ChatStateLoading value)? loading,
    TResult Function(ChatStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class ChatStateData implements ChatState {
  const factory ChatStateData(
      final TextEditingController textEditingController,
      final MessageDataSource messageDataSource,
      final ChatActionStatus chatActionStatus,
      {final MessageEntity? messageEntity}) = _$ChatStateDataImpl;

  TextEditingController get textEditingController;
  MessageDataSource get messageDataSource;
  ChatActionStatus get chatActionStatus;
  MessageEntity? get messageEntity;
  @JsonKey(ignore: true)
  _$$ChatStateDataImplCopyWith<_$ChatStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatStateLoadingImplCopyWith<$Res> {
  factory _$$ChatStateLoadingImplCopyWith(_$ChatStateLoadingImpl value,
          $Res Function(_$ChatStateLoadingImpl) then) =
      __$$ChatStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatStateLoadingImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateLoadingImpl>
    implements _$$ChatStateLoadingImplCopyWith<$Res> {
  __$$ChatStateLoadingImplCopyWithImpl(_$ChatStateLoadingImpl _value,
      $Res Function(_$ChatStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatStateLoadingImpl implements ChatStateLoading {
  const _$ChatStateLoadingImpl();

  @override
  String toString() {
    return 'ChatState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
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
    TResult Function(ChatStateData value) $default, {
    required TResult Function(ChatStateLoading value) loading,
    required TResult Function(ChatStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ChatStateData value)? $default, {
    TResult? Function(ChatStateLoading value)? loading,
    TResult? Function(ChatStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ChatStateData value)? $default, {
    TResult Function(ChatStateLoading value)? loading,
    TResult Function(ChatStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatStateLoading implements ChatState {
  const factory ChatStateLoading() = _$ChatStateLoadingImpl;
}

/// @nodoc
abstract class _$$ChatStateErrorImplCopyWith<$Res> {
  factory _$$ChatStateErrorImplCopyWith(_$ChatStateErrorImpl value,
          $Res Function(_$ChatStateErrorImpl) then) =
      __$$ChatStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$ChatStateErrorImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateErrorImpl>
    implements _$$ChatStateErrorImplCopyWith<$Res> {
  __$$ChatStateErrorImplCopyWithImpl(
      _$ChatStateErrorImpl _value, $Res Function(_$ChatStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$ChatStateErrorImpl(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ChatStateErrorImpl implements ChatStateError {
  const _$ChatStateErrorImpl(this.error);

  @override
  final dynamic error;

  @override
  String toString() {
    return 'ChatState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateErrorImplCopyWith<_$ChatStateErrorImpl> get copyWith =>
      __$$ChatStateErrorImplCopyWithImpl<_$ChatStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)
        $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
        $default, {
    TResult? Function()? loading,
    TResult? Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            TextEditingController textEditingController,
            MessageDataSource messageDataSource,
            ChatActionStatus chatActionStatus,
            MessageEntity? messageEntity)?
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
    TResult Function(ChatStateData value) $default, {
    required TResult Function(ChatStateLoading value) loading,
    required TResult Function(ChatStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ChatStateData value)? $default, {
    TResult? Function(ChatStateLoading value)? loading,
    TResult? Function(ChatStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ChatStateData value)? $default, {
    TResult Function(ChatStateLoading value)? loading,
    TResult Function(ChatStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatStateError implements ChatState {
  const factory ChatStateError(final dynamic error) = _$ChatStateErrorImpl;

  dynamic get error;
  @JsonKey(ignore: true)
  _$$ChatStateErrorImplCopyWith<_$ChatStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
