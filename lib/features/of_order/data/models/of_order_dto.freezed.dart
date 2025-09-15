// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'of_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OfOrderDto _$OfOrderDtoFromJson(Map<String, dynamic> json) {
  return _OfOrderDto.fromJson(json);
}

/// @nodoc
mixin _$OfOrderDto {
  String get id => throw _privateConstructorUsedError;
  String get client => throw _privateConstructorUsedError;
  String get product => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OfOrderDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfOrderDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfOrderDtoCopyWith<OfOrderDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfOrderDtoCopyWith<$Res> {
  factory $OfOrderDtoCopyWith(
          OfOrderDto value, $Res Function(OfOrderDto) then) =
      _$OfOrderDtoCopyWithImpl<$Res, OfOrderDto>;
  @useResult
  $Res call(
      {String id,
      String client,
      String product,
      int quantity,
      String status,
      DateTime createdAt,
      String? description,
      DateTime? updatedAt});
}

/// @nodoc
class _$OfOrderDtoCopyWithImpl<$Res, $Val extends OfOrderDto>
    implements $OfOrderDtoCopyWith<$Res> {
  _$OfOrderDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfOrderDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? client = null,
    Object? product = null,
    Object? quantity = null,
    Object? status = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfOrderDtoImplCopyWith<$Res>
    implements $OfOrderDtoCopyWith<$Res> {
  factory _$$OfOrderDtoImplCopyWith(
          _$OfOrderDtoImpl value, $Res Function(_$OfOrderDtoImpl) then) =
      __$$OfOrderDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String client,
      String product,
      int quantity,
      String status,
      DateTime createdAt,
      String? description,
      DateTime? updatedAt});
}

/// @nodoc
class __$$OfOrderDtoImplCopyWithImpl<$Res>
    extends _$OfOrderDtoCopyWithImpl<$Res, _$OfOrderDtoImpl>
    implements _$$OfOrderDtoImplCopyWith<$Res> {
  __$$OfOrderDtoImplCopyWithImpl(
      _$OfOrderDtoImpl _value, $Res Function(_$OfOrderDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfOrderDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? client = null,
    Object? product = null,
    Object? quantity = null,
    Object? status = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$OfOrderDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfOrderDtoImpl extends _OfOrderDto {
  const _$OfOrderDtoImpl(
      {required this.id,
      required this.client,
      required this.product,
      required this.quantity,
      required this.status,
      required this.createdAt,
      this.description,
      this.updatedAt})
      : super._();

  factory _$OfOrderDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfOrderDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String client;
  @override
  final String product;
  @override
  final int quantity;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final String? description;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OfOrderDto(id: $id, client: $client, product: $product, quantity: $quantity, status: $status, createdAt: $createdAt, description: $description, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfOrderDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, client, product, quantity,
      status, createdAt, description, updatedAt);

  /// Create a copy of OfOrderDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfOrderDtoImplCopyWith<_$OfOrderDtoImpl> get copyWith =>
      __$$OfOrderDtoImplCopyWithImpl<_$OfOrderDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfOrderDtoImplToJson(
      this,
    );
  }
}

abstract class _OfOrderDto extends OfOrderDto {
  const factory _OfOrderDto(
      {required final String id,
      required final String client,
      required final String product,
      required final int quantity,
      required final String status,
      required final DateTime createdAt,
      final String? description,
      final DateTime? updatedAt}) = _$OfOrderDtoImpl;
  const _OfOrderDto._() : super._();

  factory _OfOrderDto.fromJson(Map<String, dynamic> json) =
      _$OfOrderDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get client;
  @override
  String get product;
  @override
  int get quantity;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  String? get description;
  @override
  DateTime? get updatedAt;

  /// Create a copy of OfOrderDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfOrderDtoImplCopyWith<_$OfOrderDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
