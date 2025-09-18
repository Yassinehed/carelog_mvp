// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Material _$MaterialFromJson(Map<String, dynamic> json) {
  return _Material.fromJson(json);
}

/// @nodoc
mixin _$Material {
  /// Unique material reference/SKU
  String get reference => throw _privateConstructorUsedError;

  /// Human-readable material name
  String get name => throw _privateConstructorUsedError;

  /// Detailed description
  String get description => throw _privateConstructorUsedError;

  /// Material category
  MaterialCategory get category => throw _privateConstructorUsedError;

  /// Unit of measurement
  MaterialUnit get unit => throw _privateConstructorUsedError;

  /// Minimum stock level (reorder point)
  int get minimumStock => throw _privateConstructorUsedError;

  /// Maximum stock level
  int? get maximumStock => throw _privateConstructorUsedError;

  /// Current stock quantity
  double get currentStock => throw _privateConstructorUsedError;

  /// Reserved quantity (allocated to orders)
  double get reservedStock => throw _privateConstructorUsedError;

  /// Available quantity (current - reserved)
  double get availableStock => throw _privateConstructorUsedError;

  /// Unit cost
  double get unitCost => throw _privateConstructorUsedError;

  /// Supplier information
  String? get supplierName => throw _privateConstructorUsedError;

  /// Supplier reference/catalog number
  String? get supplierReference => throw _privateConstructorUsedError;

  /// Lead time in days for reordering
  int? get leadTimeDays => throw _privateConstructorUsedError;

  /// Storage location
  String? get storageLocation => throw _privateConstructorUsedError;

  /// Safety stock level
  double get safetyStock => throw _privateConstructorUsedError;

  /// Quality specifications
  List<String> get qualitySpecifications => throw _privateConstructorUsedError;

  /// Material batches/lots
  List<MaterialBatch> get batches => throw _privateConstructorUsedError;

  /// Is material active (not discontinued)
  bool get isActive => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// User who created the material
  String get createdBy => throw _privateConstructorUsedError;

  /// Last user who updated the material
  String? get updatedBy => throw _privateConstructorUsedError;

  /// Version for optimistic concurrency
  int get version => throw _privateConstructorUsedError;

  /// Additional metadata
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Material to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaterialCopyWith<Material> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialCopyWith<$Res> {
  factory $MaterialCopyWith(Material value, $Res Function(Material) then) =
      _$MaterialCopyWithImpl<$Res, Material>;
  @useResult
  $Res call(
      {String reference,
      String name,
      String description,
      MaterialCategory category,
      MaterialUnit unit,
      int minimumStock,
      int? maximumStock,
      double currentStock,
      double reservedStock,
      double availableStock,
      double unitCost,
      String? supplierName,
      String? supplierReference,
      int? leadTimeDays,
      String? storageLocation,
      double safetyStock,
      List<String> qualitySpecifications,
      List<MaterialBatch> batches,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      String? updatedBy,
      int version,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$MaterialCopyWithImpl<$Res, $Val extends Material>
    implements $MaterialCopyWith<$Res> {
  _$MaterialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? unit = null,
    Object? minimumStock = null,
    Object? maximumStock = freezed,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? unitCost = null,
    Object? supplierName = freezed,
    Object? supplierReference = freezed,
    Object? leadTimeDays = freezed,
    Object? storageLocation = freezed,
    Object? safetyStock = null,
    Object? qualitySpecifications = null,
    Object? batches = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = freezed,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MaterialCategory,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MaterialUnit,
      minimumStock: null == minimumStock
          ? _value.minimumStock
          : minimumStock // ignore: cast_nullable_to_non_nullable
              as int,
      maximumStock: freezed == maximumStock
          ? _value.maximumStock
          : maximumStock // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierReference: freezed == supplierReference
          ? _value.supplierReference
          : supplierReference // ignore: cast_nullable_to_non_nullable
              as String?,
      leadTimeDays: freezed == leadTimeDays
          ? _value.leadTimeDays
          : leadTimeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      storageLocation: freezed == storageLocation
          ? _value.storageLocation
          : storageLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      safetyStock: null == safetyStock
          ? _value.safetyStock
          : safetyStock // ignore: cast_nullable_to_non_nullable
              as double,
      qualitySpecifications: null == qualitySpecifications
          ? _value.qualitySpecifications
          : qualitySpecifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      batches: null == batches
          ? _value.batches
          : batches // ignore: cast_nullable_to_non_nullable
              as List<MaterialBatch>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialImplCopyWith<$Res>
    implements $MaterialCopyWith<$Res> {
  factory _$$MaterialImplCopyWith(
          _$MaterialImpl value, $Res Function(_$MaterialImpl) then) =
      __$$MaterialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reference,
      String name,
      String description,
      MaterialCategory category,
      MaterialUnit unit,
      int minimumStock,
      int? maximumStock,
      double currentStock,
      double reservedStock,
      double availableStock,
      double unitCost,
      String? supplierName,
      String? supplierReference,
      int? leadTimeDays,
      String? storageLocation,
      double safetyStock,
      List<String> qualitySpecifications,
      List<MaterialBatch> batches,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      String? updatedBy,
      int version,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$MaterialImplCopyWithImpl<$Res>
    extends _$MaterialCopyWithImpl<$Res, _$MaterialImpl>
    implements _$$MaterialImplCopyWith<$Res> {
  __$$MaterialImplCopyWithImpl(
      _$MaterialImpl _value, $Res Function(_$MaterialImpl) _then)
      : super(_value, _then);

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? unit = null,
    Object? minimumStock = null,
    Object? maximumStock = freezed,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? unitCost = null,
    Object? supplierName = freezed,
    Object? supplierReference = freezed,
    Object? leadTimeDays = freezed,
    Object? storageLocation = freezed,
    Object? safetyStock = null,
    Object? qualitySpecifications = null,
    Object? batches = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = freezed,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_$MaterialImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MaterialCategory,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MaterialUnit,
      minimumStock: null == minimumStock
          ? _value.minimumStock
          : minimumStock // ignore: cast_nullable_to_non_nullable
              as int,
      maximumStock: freezed == maximumStock
          ? _value.maximumStock
          : maximumStock // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierReference: freezed == supplierReference
          ? _value.supplierReference
          : supplierReference // ignore: cast_nullable_to_non_nullable
              as String?,
      leadTimeDays: freezed == leadTimeDays
          ? _value.leadTimeDays
          : leadTimeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      storageLocation: freezed == storageLocation
          ? _value.storageLocation
          : storageLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      safetyStock: null == safetyStock
          ? _value.safetyStock
          : safetyStock // ignore: cast_nullable_to_non_nullable
              as double,
      qualitySpecifications: null == qualitySpecifications
          ? _value._qualitySpecifications
          : qualitySpecifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      batches: null == batches
          ? _value._batches
          : batches // ignore: cast_nullable_to_non_nullable
              as List<MaterialBatch>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialImpl extends _Material {
  const _$MaterialImpl(
      {required this.reference,
      required this.name,
      required this.description,
      required this.category,
      required this.unit,
      this.minimumStock = 0,
      this.maximumStock,
      this.currentStock = 0.0,
      this.reservedStock = 0.0,
      this.availableStock = 0.0,
      this.unitCost = 0.0,
      this.supplierName,
      this.supplierReference,
      this.leadTimeDays,
      this.storageLocation,
      this.safetyStock = 0.0,
      final List<String> qualitySpecifications = const [],
      final List<MaterialBatch> batches = const [],
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      required this.createdBy,
      this.updatedBy,
      this.version = 1,
      final Map<String, dynamic> metadata = const {}})
      : _qualitySpecifications = qualitySpecifications,
        _batches = batches,
        _metadata = metadata,
        super._();

  factory _$MaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialImplFromJson(json);

  /// Unique material reference/SKU
  @override
  final String reference;

  /// Human-readable material name
  @override
  final String name;

  /// Detailed description
  @override
  final String description;

  /// Material category
  @override
  final MaterialCategory category;

  /// Unit of measurement
  @override
  final MaterialUnit unit;

  /// Minimum stock level (reorder point)
  @override
  @JsonKey()
  final int minimumStock;

  /// Maximum stock level
  @override
  final int? maximumStock;

  /// Current stock quantity
  @override
  @JsonKey()
  final double currentStock;

  /// Reserved quantity (allocated to orders)
  @override
  @JsonKey()
  final double reservedStock;

  /// Available quantity (current - reserved)
  @override
  @JsonKey()
  final double availableStock;

  /// Unit cost
  @override
  @JsonKey()
  final double unitCost;

  /// Supplier information
  @override
  final String? supplierName;

  /// Supplier reference/catalog number
  @override
  final String? supplierReference;

  /// Lead time in days for reordering
  @override
  final int? leadTimeDays;

  /// Storage location
  @override
  final String? storageLocation;

  /// Safety stock level
  @override
  @JsonKey()
  final double safetyStock;

  /// Quality specifications
  final List<String> _qualitySpecifications;

  /// Quality specifications
  @override
  @JsonKey()
  List<String> get qualitySpecifications {
    if (_qualitySpecifications is EqualUnmodifiableListView)
      return _qualitySpecifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualitySpecifications);
  }

  /// Material batches/lots
  final List<MaterialBatch> _batches;

  /// Material batches/lots
  @override
  @JsonKey()
  List<MaterialBatch> get batches {
    if (_batches is EqualUnmodifiableListView) return _batches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_batches);
  }

  /// Is material active (not discontinued)
  @override
  @JsonKey()
  final bool isActive;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// User who created the material
  @override
  final String createdBy;

  /// Last user who updated the material
  @override
  final String? updatedBy;

  /// Version for optimistic concurrency
  @override
  @JsonKey()
  final int version;

  /// Additional metadata
  final Map<String, dynamic> _metadata;

  /// Additional metadata
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Material(reference: $reference, name: $name, description: $description, category: $category, unit: $unit, minimumStock: $minimumStock, maximumStock: $maximumStock, currentStock: $currentStock, reservedStock: $reservedStock, availableStock: $availableStock, unitCost: $unitCost, supplierName: $supplierName, supplierReference: $supplierReference, leadTimeDays: $leadTimeDays, storageLocation: $storageLocation, safetyStock: $safetyStock, qualitySpecifications: $qualitySpecifications, batches: $batches, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, version: $version, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.minimumStock, minimumStock) ||
                other.minimumStock == minimumStock) &&
            (identical(other.maximumStock, maximumStock) ||
                other.maximumStock == maximumStock) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.availableStock, availableStock) ||
                other.availableStock == availableStock) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.supplierReference, supplierReference) ||
                other.supplierReference == supplierReference) &&
            (identical(other.leadTimeDays, leadTimeDays) ||
                other.leadTimeDays == leadTimeDays) &&
            (identical(other.storageLocation, storageLocation) ||
                other.storageLocation == storageLocation) &&
            (identical(other.safetyStock, safetyStock) ||
                other.safetyStock == safetyStock) &&
            const DeepCollectionEquality()
                .equals(other._qualitySpecifications, _qualitySpecifications) &&
            const DeepCollectionEquality().equals(other._batches, _batches) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        reference,
        name,
        description,
        category,
        unit,
        minimumStock,
        maximumStock,
        currentStock,
        reservedStock,
        availableStock,
        unitCost,
        supplierName,
        supplierReference,
        leadTimeDays,
        storageLocation,
        safetyStock,
        const DeepCollectionEquality().hash(_qualitySpecifications),
        const DeepCollectionEquality().hash(_batches),
        isActive,
        createdAt,
        updatedAt,
        createdBy,
        updatedBy,
        version,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialImplCopyWith<_$MaterialImpl> get copyWith =>
      __$$MaterialImplCopyWithImpl<_$MaterialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialImplToJson(
      this,
    );
  }
}

abstract class _Material extends Material {
  const factory _Material(
      {required final String reference,
      required final String name,
      required final String description,
      required final MaterialCategory category,
      required final MaterialUnit unit,
      final int minimumStock,
      final int? maximumStock,
      final double currentStock,
      final double reservedStock,
      final double availableStock,
      final double unitCost,
      final String? supplierName,
      final String? supplierReference,
      final int? leadTimeDays,
      final String? storageLocation,
      final double safetyStock,
      final List<String> qualitySpecifications,
      final List<MaterialBatch> batches,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String createdBy,
      final String? updatedBy,
      final int version,
      final Map<String, dynamic> metadata}) = _$MaterialImpl;
  const _Material._() : super._();

  factory _Material.fromJson(Map<String, dynamic> json) =
      _$MaterialImpl.fromJson;

  /// Unique material reference/SKU
  @override
  String get reference;

  /// Human-readable material name
  @override
  String get name;

  /// Detailed description
  @override
  String get description;

  /// Material category
  @override
  MaterialCategory get category;

  /// Unit of measurement
  @override
  MaterialUnit get unit;

  /// Minimum stock level (reorder point)
  @override
  int get minimumStock;

  /// Maximum stock level
  @override
  int? get maximumStock;

  /// Current stock quantity
  @override
  double get currentStock;

  /// Reserved quantity (allocated to orders)
  @override
  double get reservedStock;

  /// Available quantity (current - reserved)
  @override
  double get availableStock;

  /// Unit cost
  @override
  double get unitCost;

  /// Supplier information
  @override
  String? get supplierName;

  /// Supplier reference/catalog number
  @override
  String? get supplierReference;

  /// Lead time in days for reordering
  @override
  int? get leadTimeDays;

  /// Storage location
  @override
  String? get storageLocation;

  /// Safety stock level
  @override
  double get safetyStock;

  /// Quality specifications
  @override
  List<String> get qualitySpecifications;

  /// Material batches/lots
  @override
  List<MaterialBatch> get batches;

  /// Is material active (not discontinued)
  @override
  bool get isActive;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// User who created the material
  @override
  String get createdBy;

  /// Last user who updated the material
  @override
  String? get updatedBy;

  /// Version for optimistic concurrency
  @override
  int get version;

  /// Additional metadata
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaterialImplCopyWith<_$MaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MaterialBatch _$MaterialBatchFromJson(Map<String, dynamic> json) {
  return _MaterialBatch.fromJson(json);
}

/// @nodoc
mixin _$MaterialBatch {
  /// Unique batch identifier
  String get batchId => throw _privateConstructorUsedError;

  /// Quantity in this batch
  double get quantity => throw _privateConstructorUsedError;

  /// Quality status
  MaterialQualityStatus get qualityStatus => throw _privateConstructorUsedError;

  /// Supplier batch/lot number
  String? get supplierBatchId => throw _privateConstructorUsedError;

  /// Manufacturing date
  DateTime? get manufacturingDate => throw _privateConstructorUsedError;

  /// Expiration date
  DateTime? get expirationDate => throw _privateConstructorUsedError;

  /// Receipt date
  DateTime get receiptDate => throw _privateConstructorUsedError;

  /// Quality check date
  DateTime? get qualityCheckDate => throw _privateConstructorUsedError;

  /// Quality inspector
  String? get qualityInspector => throw _privateConstructorUsedError;

  /// Quality notes
  String? get qualityNotes => throw _privateConstructorUsedError;

  /// Certificate of analysis reference
  String? get certificateReference => throw _privateConstructorUsedError;

  /// Storage conditions
  String? get storageConditions => throw _privateConstructorUsedError;

  /// Remaining quantity in this batch
  double? get remainingQuantity => throw _privateConstructorUsedError;

  /// Is batch active (not expired/consumed)
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this MaterialBatch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MaterialBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaterialBatchCopyWith<MaterialBatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialBatchCopyWith<$Res> {
  factory $MaterialBatchCopyWith(
          MaterialBatch value, $Res Function(MaterialBatch) then) =
      _$MaterialBatchCopyWithImpl<$Res, MaterialBatch>;
  @useResult
  $Res call(
      {String batchId,
      double quantity,
      MaterialQualityStatus qualityStatus,
      String? supplierBatchId,
      DateTime? manufacturingDate,
      DateTime? expirationDate,
      DateTime receiptDate,
      DateTime? qualityCheckDate,
      String? qualityInspector,
      String? qualityNotes,
      String? certificateReference,
      String? storageConditions,
      double? remainingQuantity,
      bool isActive});
}

/// @nodoc
class _$MaterialBatchCopyWithImpl<$Res, $Val extends MaterialBatch>
    implements $MaterialBatchCopyWith<$Res> {
  _$MaterialBatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MaterialBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? batchId = null,
    Object? quantity = null,
    Object? qualityStatus = null,
    Object? supplierBatchId = freezed,
    Object? manufacturingDate = freezed,
    Object? expirationDate = freezed,
    Object? receiptDate = null,
    Object? qualityCheckDate = freezed,
    Object? qualityInspector = freezed,
    Object? qualityNotes = freezed,
    Object? certificateReference = freezed,
    Object? storageConditions = freezed,
    Object? remainingQuantity = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      batchId: null == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      qualityStatus: null == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as MaterialQualityStatus,
      supplierBatchId: freezed == supplierBatchId
          ? _value.supplierBatchId
          : supplierBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturingDate: freezed == manufacturingDate
          ? _value.manufacturingDate
          : manufacturingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receiptDate: null == receiptDate
          ? _value.receiptDate
          : receiptDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      qualityCheckDate: freezed == qualityCheckDate
          ? _value.qualityCheckDate
          : qualityCheckDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qualityInspector: freezed == qualityInspector
          ? _value.qualityInspector
          : qualityInspector // ignore: cast_nullable_to_non_nullable
              as String?,
      qualityNotes: freezed == qualityNotes
          ? _value.qualityNotes
          : qualityNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      certificateReference: freezed == certificateReference
          ? _value.certificateReference
          : certificateReference // ignore: cast_nullable_to_non_nullable
              as String?,
      storageConditions: freezed == storageConditions
          ? _value.storageConditions
          : storageConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      remainingQuantity: freezed == remainingQuantity
          ? _value.remainingQuantity
          : remainingQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialBatchImplCopyWith<$Res>
    implements $MaterialBatchCopyWith<$Res> {
  factory _$$MaterialBatchImplCopyWith(
          _$MaterialBatchImpl value, $Res Function(_$MaterialBatchImpl) then) =
      __$$MaterialBatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String batchId,
      double quantity,
      MaterialQualityStatus qualityStatus,
      String? supplierBatchId,
      DateTime? manufacturingDate,
      DateTime? expirationDate,
      DateTime receiptDate,
      DateTime? qualityCheckDate,
      String? qualityInspector,
      String? qualityNotes,
      String? certificateReference,
      String? storageConditions,
      double? remainingQuantity,
      bool isActive});
}

/// @nodoc
class __$$MaterialBatchImplCopyWithImpl<$Res>
    extends _$MaterialBatchCopyWithImpl<$Res, _$MaterialBatchImpl>
    implements _$$MaterialBatchImplCopyWith<$Res> {
  __$$MaterialBatchImplCopyWithImpl(
      _$MaterialBatchImpl _value, $Res Function(_$MaterialBatchImpl) _then)
      : super(_value, _then);

  /// Create a copy of MaterialBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? batchId = null,
    Object? quantity = null,
    Object? qualityStatus = null,
    Object? supplierBatchId = freezed,
    Object? manufacturingDate = freezed,
    Object? expirationDate = freezed,
    Object? receiptDate = null,
    Object? qualityCheckDate = freezed,
    Object? qualityInspector = freezed,
    Object? qualityNotes = freezed,
    Object? certificateReference = freezed,
    Object? storageConditions = freezed,
    Object? remainingQuantity = freezed,
    Object? isActive = null,
  }) {
    return _then(_$MaterialBatchImpl(
      batchId: null == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      qualityStatus: null == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as MaterialQualityStatus,
      supplierBatchId: freezed == supplierBatchId
          ? _value.supplierBatchId
          : supplierBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturingDate: freezed == manufacturingDate
          ? _value.manufacturingDate
          : manufacturingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receiptDate: null == receiptDate
          ? _value.receiptDate
          : receiptDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      qualityCheckDate: freezed == qualityCheckDate
          ? _value.qualityCheckDate
          : qualityCheckDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qualityInspector: freezed == qualityInspector
          ? _value.qualityInspector
          : qualityInspector // ignore: cast_nullable_to_non_nullable
              as String?,
      qualityNotes: freezed == qualityNotes
          ? _value.qualityNotes
          : qualityNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      certificateReference: freezed == certificateReference
          ? _value.certificateReference
          : certificateReference // ignore: cast_nullable_to_non_nullable
              as String?,
      storageConditions: freezed == storageConditions
          ? _value.storageConditions
          : storageConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      remainingQuantity: freezed == remainingQuantity
          ? _value.remainingQuantity
          : remainingQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialBatchImpl extends _MaterialBatch {
  const _$MaterialBatchImpl(
      {required this.batchId,
      required this.quantity,
      this.qualityStatus = MaterialQualityStatus.pending,
      this.supplierBatchId,
      this.manufacturingDate,
      this.expirationDate,
      required this.receiptDate,
      this.qualityCheckDate,
      this.qualityInspector,
      this.qualityNotes,
      this.certificateReference,
      this.storageConditions,
      this.remainingQuantity,
      this.isActive = true})
      : super._();

  factory _$MaterialBatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialBatchImplFromJson(json);

  /// Unique batch identifier
  @override
  final String batchId;

  /// Quantity in this batch
  @override
  final double quantity;

  /// Quality status
  @override
  @JsonKey()
  final MaterialQualityStatus qualityStatus;

  /// Supplier batch/lot number
  @override
  final String? supplierBatchId;

  /// Manufacturing date
  @override
  final DateTime? manufacturingDate;

  /// Expiration date
  @override
  final DateTime? expirationDate;

  /// Receipt date
  @override
  final DateTime receiptDate;

  /// Quality check date
  @override
  final DateTime? qualityCheckDate;

  /// Quality inspector
  @override
  final String? qualityInspector;

  /// Quality notes
  @override
  final String? qualityNotes;

  /// Certificate of analysis reference
  @override
  final String? certificateReference;

  /// Storage conditions
  @override
  final String? storageConditions;

  /// Remaining quantity in this batch
  @override
  final double? remainingQuantity;

  /// Is batch active (not expired/consumed)
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'MaterialBatch(batchId: $batchId, quantity: $quantity, qualityStatus: $qualityStatus, supplierBatchId: $supplierBatchId, manufacturingDate: $manufacturingDate, expirationDate: $expirationDate, receiptDate: $receiptDate, qualityCheckDate: $qualityCheckDate, qualityInspector: $qualityInspector, qualityNotes: $qualityNotes, certificateReference: $certificateReference, storageConditions: $storageConditions, remainingQuantity: $remainingQuantity, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialBatchImpl &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.qualityStatus, qualityStatus) ||
                other.qualityStatus == qualityStatus) &&
            (identical(other.supplierBatchId, supplierBatchId) ||
                other.supplierBatchId == supplierBatchId) &&
            (identical(other.manufacturingDate, manufacturingDate) ||
                other.manufacturingDate == manufacturingDate) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.receiptDate, receiptDate) ||
                other.receiptDate == receiptDate) &&
            (identical(other.qualityCheckDate, qualityCheckDate) ||
                other.qualityCheckDate == qualityCheckDate) &&
            (identical(other.qualityInspector, qualityInspector) ||
                other.qualityInspector == qualityInspector) &&
            (identical(other.qualityNotes, qualityNotes) ||
                other.qualityNotes == qualityNotes) &&
            (identical(other.certificateReference, certificateReference) ||
                other.certificateReference == certificateReference) &&
            (identical(other.storageConditions, storageConditions) ||
                other.storageConditions == storageConditions) &&
            (identical(other.remainingQuantity, remainingQuantity) ||
                other.remainingQuantity == remainingQuantity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      batchId,
      quantity,
      qualityStatus,
      supplierBatchId,
      manufacturingDate,
      expirationDate,
      receiptDate,
      qualityCheckDate,
      qualityInspector,
      qualityNotes,
      certificateReference,
      storageConditions,
      remainingQuantity,
      isActive);

  /// Create a copy of MaterialBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialBatchImplCopyWith<_$MaterialBatchImpl> get copyWith =>
      __$$MaterialBatchImplCopyWithImpl<_$MaterialBatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialBatchImplToJson(
      this,
    );
  }
}

abstract class _MaterialBatch extends MaterialBatch {
  const factory _MaterialBatch(
      {required final String batchId,
      required final double quantity,
      final MaterialQualityStatus qualityStatus,
      final String? supplierBatchId,
      final DateTime? manufacturingDate,
      final DateTime? expirationDate,
      required final DateTime receiptDate,
      final DateTime? qualityCheckDate,
      final String? qualityInspector,
      final String? qualityNotes,
      final String? certificateReference,
      final String? storageConditions,
      final double? remainingQuantity,
      final bool isActive}) = _$MaterialBatchImpl;
  const _MaterialBatch._() : super._();

  factory _MaterialBatch.fromJson(Map<String, dynamic> json) =
      _$MaterialBatchImpl.fromJson;

  /// Unique batch identifier
  @override
  String get batchId;

  /// Quantity in this batch
  @override
  double get quantity;

  /// Quality status
  @override
  MaterialQualityStatus get qualityStatus;

  /// Supplier batch/lot number
  @override
  String? get supplierBatchId;

  /// Manufacturing date
  @override
  DateTime? get manufacturingDate;

  /// Expiration date
  @override
  DateTime? get expirationDate;

  /// Receipt date
  @override
  DateTime get receiptDate;

  /// Quality check date
  @override
  DateTime? get qualityCheckDate;

  /// Quality inspector
  @override
  String? get qualityInspector;

  /// Quality notes
  @override
  String? get qualityNotes;

  /// Certificate of analysis reference
  @override
  String? get certificateReference;

  /// Storage conditions
  @override
  String? get storageConditions;

  /// Remaining quantity in this batch
  @override
  double? get remainingQuantity;

  /// Is batch active (not expired/consumed)
  @override
  bool get isActive;

  /// Create a copy of MaterialBatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaterialBatchImplCopyWith<_$MaterialBatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
