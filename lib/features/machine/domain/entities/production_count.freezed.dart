// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductionCount _$ProductionCountFromJson(Map<String, dynamic> json) {
  return _ProductionCount.fromJson(json);
}

/// @nodoc
mixin _$ProductionCount {
  String get id => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ProductionCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductionCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductionCountCopyWith<ProductionCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductionCountCopyWith<$Res> {
  factory $ProductionCountCopyWith(
          ProductionCount value, $Res Function(ProductionCount) then) =
      _$ProductionCountCopyWithImpl<$Res, ProductionCount>;
  @useResult
  $Res call({String id, int count, DateTime? timestamp});
}

/// @nodoc
class _$ProductionCountCopyWithImpl<$Res, $Val extends ProductionCount>
    implements $ProductionCountCopyWith<$Res> {
  _$ProductionCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductionCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? count = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductionCountImplCopyWith<$Res>
    implements $ProductionCountCopyWith<$Res> {
  factory _$$ProductionCountImplCopyWith(_$ProductionCountImpl value,
          $Res Function(_$ProductionCountImpl) then) =
      __$$ProductionCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int count, DateTime? timestamp});
}

/// @nodoc
class __$$ProductionCountImplCopyWithImpl<$Res>
    extends _$ProductionCountCopyWithImpl<$Res, _$ProductionCountImpl>
    implements _$$ProductionCountImplCopyWith<$Res> {
  __$$ProductionCountImplCopyWithImpl(
      _$ProductionCountImpl _value, $Res Function(_$ProductionCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductionCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? count = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$ProductionCountImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductionCountImpl implements _ProductionCount {
  const _$ProductionCountImpl(
      {required this.id, required this.count, this.timestamp});

  factory _$ProductionCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductionCountImplFromJson(json);

  @override
  final String id;
  @override
  final int count;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ProductionCount(id: $id, count: $count, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductionCountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, count, timestamp);

  /// Create a copy of ProductionCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductionCountImplCopyWith<_$ProductionCountImpl> get copyWith =>
      __$$ProductionCountImplCopyWithImpl<_$ProductionCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductionCountImplToJson(
      this,
    );
  }
}

abstract class _ProductionCount implements ProductionCount {
  const factory _ProductionCount(
      {required final String id,
      required final int count,
      final DateTime? timestamp}) = _$ProductionCountImpl;

  factory _ProductionCount.fromJson(Map<String, dynamic> json) =
      _$ProductionCountImpl.fromJson;

  @override
  String get id;
  @override
  int get count;
  @override
  DateTime? get timestamp;

  /// Create a copy of ProductionCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductionCountImplCopyWith<_$ProductionCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
