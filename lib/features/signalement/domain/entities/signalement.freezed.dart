// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signalement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Signalement {
  String get id => throw _privateConstructorUsedError;
  SignalementType get type => throw _privateConstructorUsedError;
  SignalementSeverity get severity => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  SignalementStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignalementCopyWith<Signalement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignalementCopyWith<$Res> {
  factory $SignalementCopyWith(
          Signalement value, $Res Function(Signalement) then) =
      _$SignalementCopyWithImpl<$Res, Signalement>;
  @useResult
  $Res call(
      {String id,
      SignalementType type,
      SignalementSeverity severity,
      String createdBy,
      DateTime createdAt,
      String description,
      SignalementStatus status});
}

/// @nodoc
class _$SignalementCopyWithImpl<$Res, $Val extends Signalement>
    implements $SignalementCopyWith<$Res> {
  _$SignalementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? description = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalementType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SignalementSeverity,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalementStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignalementImplCopyWith<$Res>
    implements $SignalementCopyWith<$Res> {
  factory _$$SignalementImplCopyWith(
          _$SignalementImpl value, $Res Function(_$SignalementImpl) then) =
      __$$SignalementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SignalementType type,
      SignalementSeverity severity,
      String createdBy,
      DateTime createdAt,
      String description,
      SignalementStatus status});
}

/// @nodoc
class __$$SignalementImplCopyWithImpl<$Res>
    extends _$SignalementCopyWithImpl<$Res, _$SignalementImpl>
    implements _$$SignalementImplCopyWith<$Res> {
  __$$SignalementImplCopyWithImpl(
      _$SignalementImpl _value, $Res Function(_$SignalementImpl) _then)
      : super(_value, _then);

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? description = null,
    Object? status = null,
  }) {
    return _then(_$SignalementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalementType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as SignalementSeverity,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalementStatus,
    ));
  }
}

/// @nodoc

class _$SignalementImpl extends _Signalement {
  const _$SignalementImpl(
      {required this.id,
      required this.type,
      required this.severity,
      required this.createdBy,
      required this.createdAt,
      required this.description,
      required this.status})
      : super._();

  @override
  final String id;
  @override
  final SignalementType type;
  @override
  final SignalementSeverity severity;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  final String description;
  @override
  final SignalementStatus status;

  @override
  String toString() {
    return 'Signalement(id: $id, type: $type, severity: $severity, createdBy: $createdBy, createdAt: $createdAt, description: $description, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, type, severity, createdBy,
      createdAt, description, status);

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignalementImplCopyWith<_$SignalementImpl> get copyWith =>
      __$$SignalementImplCopyWithImpl<_$SignalementImpl>(this, _$identity);
}

abstract class _Signalement extends Signalement {
  const factory _Signalement(
      {required final String id,
      required final SignalementType type,
      required final SignalementSeverity severity,
      required final String createdBy,
      required final DateTime createdAt,
      required final String description,
      required final SignalementStatus status}) = _$SignalementImpl;
  const _Signalement._() : super._();

  @override
  String get id;
  @override
  SignalementType get type;
  @override
  SignalementSeverity get severity;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  String get description;
  @override
  SignalementStatus get status;

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignalementImplCopyWith<_$SignalementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
