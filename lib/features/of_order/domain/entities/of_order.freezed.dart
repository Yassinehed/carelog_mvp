// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'of_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OfOrder {
  String get id => throw _privateConstructorUsedError;
  String get client => throw _privateConstructorUsedError;
  String get product => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  OfOrderStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of OfOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfOrderCopyWith<OfOrder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfOrderCopyWith<$Res> {
  factory $OfOrderCopyWith(OfOrder value, $Res Function(OfOrder) then) =
      _$OfOrderCopyWithImpl<$Res, OfOrder>;
  @useResult
  $Res call(
      {String id,
      String client,
      String product,
      int quantity,
      OfOrderStatus status,
      DateTime createdAt,
      String? description,
      DateTime? updatedAt});
}

/// @nodoc
class _$OfOrderCopyWithImpl<$Res, $Val extends OfOrder>
    implements $OfOrderCopyWith<$Res> {
  _$OfOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfOrder
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
              as OfOrderStatus,
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
abstract class _$$OfOrderImplCopyWith<$Res> implements $OfOrderCopyWith<$Res> {
  factory _$$OfOrderImplCopyWith(
          _$OfOrderImpl value, $Res Function(_$OfOrderImpl) then) =
      __$$OfOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String client,
      String product,
      int quantity,
      OfOrderStatus status,
      DateTime createdAt,
      String? description,
      DateTime? updatedAt});
}

/// @nodoc
class __$$OfOrderImplCopyWithImpl<$Res>
    extends _$OfOrderCopyWithImpl<$Res, _$OfOrderImpl>
    implements _$$OfOrderImplCopyWith<$Res> {
  __$$OfOrderImplCopyWithImpl(
      _$OfOrderImpl _value, $Res Function(_$OfOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfOrder
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
    return _then(_$OfOrderImpl(
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
              as OfOrderStatus,
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

class _$OfOrderImpl extends _OfOrder {
  const _$OfOrderImpl(
      {required this.id,
      required this.client,
      required this.product,
      required this.quantity,
      required this.status,
      required this.createdAt,
      this.description,
      this.updatedAt})
      : super._();

  @override
  final String id;
  @override
  final String client;
  @override
  final String product;
  @override
  final int quantity;
  @override
  final OfOrderStatus status;
  @override
  final DateTime createdAt;
  @override
  final String? description;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OfOrder(id: $id, client: $client, product: $product, quantity: $quantity, status: $status, createdAt: $createdAt, description: $description, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfOrderImpl &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, client, product, quantity,
      status, createdAt, description, updatedAt);

  /// Create a copy of OfOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfOrderImplCopyWith<_$OfOrderImpl> get copyWith =>
      __$$OfOrderImplCopyWithImpl<_$OfOrderImpl>(this, _$identity);
}

abstract class _OfOrder extends OfOrder {
  const factory _OfOrder(
      {required final String id,
      required final String client,
      required final String product,
      required final int quantity,
      required final OfOrderStatus status,
      required final DateTime createdAt,
      final String? description,
      final DateTime? updatedAt}) = _$OfOrderImpl;
  const _OfOrder._() : super._();

  @override
  String get id;
  @override
  String get client;
  @override
  String get product;
  @override
  int get quantity;
  @override
  OfOrderStatus get status;
  @override
  DateTime get createdAt;
  @override
  String? get description;
  @override
  DateTime? get updatedAt;

  /// Create a copy of OfOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfOrderImplCopyWith<_$OfOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
