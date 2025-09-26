// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'machine_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MachineAlert _$MachineAlertFromJson(Map<String, dynamic> json) {
  return _MachineAlert.fromJson(json);
}

/// @nodoc
mixin _$MachineAlert {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MachineAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MachineAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MachineAlertCopyWith<MachineAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MachineAlertCopyWith<$Res> {
  factory $MachineAlertCopyWith(
          MachineAlert value, $Res Function(MachineAlert) then) =
      _$MachineAlertCopyWithImpl<$Res, MachineAlert>;
  @useResult
  $Res call({String id, String code, String message, DateTime? timestamp});
}

/// @nodoc
class _$MachineAlertCopyWithImpl<$Res, $Val extends MachineAlert>
    implements $MachineAlertCopyWith<$Res> {
  _$MachineAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MachineAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? message = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MachineAlertImplCopyWith<$Res>
    implements $MachineAlertCopyWith<$Res> {
  factory _$$MachineAlertImplCopyWith(
          _$MachineAlertImpl value, $Res Function(_$MachineAlertImpl) then) =
      __$$MachineAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String code, String message, DateTime? timestamp});
}

/// @nodoc
class __$$MachineAlertImplCopyWithImpl<$Res>
    extends _$MachineAlertCopyWithImpl<$Res, _$MachineAlertImpl>
    implements _$$MachineAlertImplCopyWith<$Res> {
  __$$MachineAlertImplCopyWithImpl(
      _$MachineAlertImpl _value, $Res Function(_$MachineAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of MachineAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? message = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$MachineAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MachineAlertImpl implements _MachineAlert {
  const _$MachineAlertImpl(
      {required this.id,
      required this.code,
      required this.message,
      this.timestamp});

  factory _$MachineAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$MachineAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String message;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'MachineAlert(id: $id, code: $code, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MachineAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, message, timestamp);

  /// Create a copy of MachineAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MachineAlertImplCopyWith<_$MachineAlertImpl> get copyWith =>
      __$$MachineAlertImplCopyWithImpl<_$MachineAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MachineAlertImplToJson(
      this,
    );
  }
}

abstract class _MachineAlert implements MachineAlert {
  const factory _MachineAlert(
      {required final String id,
      required final String code,
      required final String message,
      final DateTime? timestamp}) = _$MachineAlertImpl;

  factory _MachineAlert.fromJson(Map<String, dynamic> json) =
      _$MachineAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get message;
  @override
  DateTime? get timestamp;

  /// Create a copy of MachineAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MachineAlertImplCopyWith<_$MachineAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
