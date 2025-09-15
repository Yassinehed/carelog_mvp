// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'of_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OfOrder _$OfOrderFromJson(Map<String, dynamic> json) {
  return _OfOrder.fromJson(json);
}

/// @nodoc
mixin _$OfOrder {
  /// Unique OF number (Manufacturing Order Number)
  String get ofNumber => throw _privateConstructorUsedError;

  /// Human-readable title/description
  String get title => throw _privateConstructorUsedError;

  /// Detailed description of the manufacturing requirements
  String get description => throw _privateConstructorUsedError;

  /// Client/customer name
  String get clientName => throw _privateConstructorUsedError;

  /// Product reference/SKU
  String get productReference => throw _privateConstructorUsedError;

  /// Planned quantity to produce
  int get plannedQuantity => throw _privateConstructorUsedError;

  /// Unit of measurement (pieces, kg, meters, etc.)
  String get unit => throw _privateConstructorUsedError;

  /// Current status in the workflow
  OfOrderStatus get status => throw _privateConstructorUsedError;

  /// Priority level
  OfOrderPriority get priority => throw _privateConstructorUsedError;

  /// Quality control status
  QualityStatus get qualityStatus => throw _privateConstructorUsedError;

  /// Assigned production line/machine
  String? get productionLine => throw _privateConstructorUsedError;

  /// Supervisor/lead operator ID
  String? get supervisorId => throw _privateConstructorUsedError;

  /// Planned start date
  DateTime? get plannedStartDate => throw _privateConstructorUsedError;

  /// Actual start date
  DateTime? get actualStartDate => throw _privateConstructorUsedError;

  /// Planned completion date
  DateTime? get plannedCompletionDate => throw _privateConstructorUsedError;

  /// Actual completion date
  DateTime? get actualCompletionDate => throw _privateConstructorUsedError;

  /// Delivery deadline
  DateTime? get deliveryDeadline => throw _privateConstructorUsedError;

  /// Actual delivery date
  DateTime? get actualDeliveryDate => throw _privateConstructorUsedError;

  /// Materials required (list of material references)
  List<String> get requiredMaterials => throw _privateConstructorUsedError;

  /// Quality specifications/checkpoints
  List<String> get qualitySpecifications => throw _privateConstructorUsedError;

  /// Production notes/progress updates
  List<ProductionNote> get productionNotes =>
      throw _privateConstructorUsedError;

  /// Quality control results
  List<QualityCheck> get qualityChecks => throw _privateConstructorUsedError;

  /// Current progress percentage (0-100)
  int get progressPercentage => throw _privateConstructorUsedError;

  /// Quantity actually produced
  int get actualQuantity => throw _privateConstructorUsedError;

  /// Quantity that passed quality control
  int get goodQuantity => throw _privateConstructorUsedError;

  /// Quantity rejected/scrap
  int get rejectedQuantity => throw _privateConstructorUsedError;

  /// Budget allocated for this order
  double? get allocatedBudget => throw _privateConstructorUsedError;

  /// Actual costs incurred
  double get actualCost => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// User who created the order
  String get createdBy => throw _privateConstructorUsedError;

  /// Last user who updated the order
  String? get updatedBy => throw _privateConstructorUsedError;

  /// Version for optimistic concurrency
  int get version => throw _privateConstructorUsedError;

  /// Additional metadata
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this OfOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
      {String ofNumber,
      String title,
      String description,
      String clientName,
      String productReference,
      int plannedQuantity,
      String unit,
      OfOrderStatus status,
      OfOrderPriority priority,
      QualityStatus qualityStatus,
      String? productionLine,
      String? supervisorId,
      DateTime? plannedStartDate,
      DateTime? actualStartDate,
      DateTime? plannedCompletionDate,
      DateTime? actualCompletionDate,
      DateTime? deliveryDeadline,
      DateTime? actualDeliveryDate,
      List<String> requiredMaterials,
      List<String> qualitySpecifications,
      List<ProductionNote> productionNotes,
      List<QualityCheck> qualityChecks,
      int progressPercentage,
      int actualQuantity,
      int goodQuantity,
      int rejectedQuantity,
      double? allocatedBudget,
      double actualCost,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      String? updatedBy,
      int version,
      Map<String, dynamic> metadata});
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
    Object? ofNumber = null,
    Object? title = null,
    Object? description = null,
    Object? clientName = null,
    Object? productReference = null,
    Object? plannedQuantity = null,
    Object? unit = null,
    Object? status = null,
    Object? priority = null,
    Object? qualityStatus = null,
    Object? productionLine = freezed,
    Object? supervisorId = freezed,
    Object? plannedStartDate = freezed,
    Object? actualStartDate = freezed,
    Object? plannedCompletionDate = freezed,
    Object? actualCompletionDate = freezed,
    Object? deliveryDeadline = freezed,
    Object? actualDeliveryDate = freezed,
    Object? requiredMaterials = null,
    Object? qualitySpecifications = null,
    Object? productionNotes = null,
    Object? qualityChecks = null,
    Object? progressPercentage = null,
    Object? actualQuantity = null,
    Object? goodQuantity = null,
    Object? rejectedQuantity = null,
    Object? allocatedBudget = freezed,
    Object? actualCost = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = freezed,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      ofNumber: null == ofNumber
          ? _value.ofNumber
          : ofNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      productReference: null == productReference
          ? _value.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as String,
      plannedQuantity: null == plannedQuantity
          ? _value.plannedQuantity
          : plannedQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OfOrderStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as OfOrderPriority,
      qualityStatus: null == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as QualityStatus,
      productionLine: freezed == productionLine
          ? _value.productionLine
          : productionLine // ignore: cast_nullable_to_non_nullable
              as String?,
      supervisorId: freezed == supervisorId
          ? _value.supervisorId
          : supervisorId // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedStartDate: freezed == plannedStartDate
          ? _value.plannedStartDate
          : plannedStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualStartDate: freezed == actualStartDate
          ? _value.actualStartDate
          : actualStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plannedCompletionDate: freezed == plannedCompletionDate
          ? _value.plannedCompletionDate
          : plannedCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualCompletionDate: freezed == actualCompletionDate
          ? _value.actualCompletionDate
          : actualCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryDeadline: freezed == deliveryDeadline
          ? _value.deliveryDeadline
          : deliveryDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDeliveryDate: freezed == actualDeliveryDate
          ? _value.actualDeliveryDate
          : actualDeliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requiredMaterials: null == requiredMaterials
          ? _value.requiredMaterials
          : requiredMaterials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualitySpecifications: null == qualitySpecifications
          ? _value.qualitySpecifications
          : qualitySpecifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionNotes: null == productionNotes
          ? _value.productionNotes
          : productionNotes // ignore: cast_nullable_to_non_nullable
              as List<ProductionNote>,
      qualityChecks: null == qualityChecks
          ? _value.qualityChecks
          : qualityChecks // ignore: cast_nullable_to_non_nullable
              as List<QualityCheck>,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      goodQuantity: null == goodQuantity
          ? _value.goodQuantity
          : goodQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedQuantity: null == rejectedQuantity
          ? _value.rejectedQuantity
          : rejectedQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      allocatedBudget: freezed == allocatedBudget
          ? _value.allocatedBudget
          : allocatedBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      actualCost: null == actualCost
          ? _value.actualCost
          : actualCost // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$OfOrderImplCopyWith<$Res> implements $OfOrderCopyWith<$Res> {
  factory _$$OfOrderImplCopyWith(
          _$OfOrderImpl value, $Res Function(_$OfOrderImpl) then) =
      __$$OfOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ofNumber,
      String title,
      String description,
      String clientName,
      String productReference,
      int plannedQuantity,
      String unit,
      OfOrderStatus status,
      OfOrderPriority priority,
      QualityStatus qualityStatus,
      String? productionLine,
      String? supervisorId,
      DateTime? plannedStartDate,
      DateTime? actualStartDate,
      DateTime? plannedCompletionDate,
      DateTime? actualCompletionDate,
      DateTime? deliveryDeadline,
      DateTime? actualDeliveryDate,
      List<String> requiredMaterials,
      List<String> qualitySpecifications,
      List<ProductionNote> productionNotes,
      List<QualityCheck> qualityChecks,
      int progressPercentage,
      int actualQuantity,
      int goodQuantity,
      int rejectedQuantity,
      double? allocatedBudget,
      double actualCost,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      String? updatedBy,
      int version,
      Map<String, dynamic> metadata});
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
    Object? ofNumber = null,
    Object? title = null,
    Object? description = null,
    Object? clientName = null,
    Object? productReference = null,
    Object? plannedQuantity = null,
    Object? unit = null,
    Object? status = null,
    Object? priority = null,
    Object? qualityStatus = null,
    Object? productionLine = freezed,
    Object? supervisorId = freezed,
    Object? plannedStartDate = freezed,
    Object? actualStartDate = freezed,
    Object? plannedCompletionDate = freezed,
    Object? actualCompletionDate = freezed,
    Object? deliveryDeadline = freezed,
    Object? actualDeliveryDate = freezed,
    Object? requiredMaterials = null,
    Object? qualitySpecifications = null,
    Object? productionNotes = null,
    Object? qualityChecks = null,
    Object? progressPercentage = null,
    Object? actualQuantity = null,
    Object? goodQuantity = null,
    Object? rejectedQuantity = null,
    Object? allocatedBudget = freezed,
    Object? actualCost = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = freezed,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_$OfOrderImpl(
      ofNumber: null == ofNumber
          ? _value.ofNumber
          : ofNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      productReference: null == productReference
          ? _value.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as String,
      plannedQuantity: null == plannedQuantity
          ? _value.plannedQuantity
          : plannedQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OfOrderStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as OfOrderPriority,
      qualityStatus: null == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as QualityStatus,
      productionLine: freezed == productionLine
          ? _value.productionLine
          : productionLine // ignore: cast_nullable_to_non_nullable
              as String?,
      supervisorId: freezed == supervisorId
          ? _value.supervisorId
          : supervisorId // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedStartDate: freezed == plannedStartDate
          ? _value.plannedStartDate
          : plannedStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualStartDate: freezed == actualStartDate
          ? _value.actualStartDate
          : actualStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plannedCompletionDate: freezed == plannedCompletionDate
          ? _value.plannedCompletionDate
          : plannedCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualCompletionDate: freezed == actualCompletionDate
          ? _value.actualCompletionDate
          : actualCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryDeadline: freezed == deliveryDeadline
          ? _value.deliveryDeadline
          : deliveryDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDeliveryDate: freezed == actualDeliveryDate
          ? _value.actualDeliveryDate
          : actualDeliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requiredMaterials: null == requiredMaterials
          ? _value._requiredMaterials
          : requiredMaterials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualitySpecifications: null == qualitySpecifications
          ? _value._qualitySpecifications
          : qualitySpecifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionNotes: null == productionNotes
          ? _value._productionNotes
          : productionNotes // ignore: cast_nullable_to_non_nullable
              as List<ProductionNote>,
      qualityChecks: null == qualityChecks
          ? _value._qualityChecks
          : qualityChecks // ignore: cast_nullable_to_non_nullable
              as List<QualityCheck>,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      goodQuantity: null == goodQuantity
          ? _value.goodQuantity
          : goodQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedQuantity: null == rejectedQuantity
          ? _value.rejectedQuantity
          : rejectedQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      allocatedBudget: freezed == allocatedBudget
          ? _value.allocatedBudget
          : allocatedBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      actualCost: null == actualCost
          ? _value.actualCost
          : actualCost // ignore: cast_nullable_to_non_nullable
              as double,
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
class _$OfOrderImpl extends _OfOrder {
  const _$OfOrderImpl(
      {required this.ofNumber,
      required this.title,
      required this.description,
      required this.clientName,
      required this.productReference,
      required this.plannedQuantity,
      required this.unit,
      required this.status,
      required this.priority,
      this.qualityStatus = QualityStatus.pending,
      this.productionLine,
      this.supervisorId,
      this.plannedStartDate,
      this.actualStartDate,
      this.plannedCompletionDate,
      this.actualCompletionDate,
      this.deliveryDeadline,
      this.actualDeliveryDate,
      final List<String> requiredMaterials = const [],
      final List<String> qualitySpecifications = const [],
      final List<ProductionNote> productionNotes = const [],
      final List<QualityCheck> qualityChecks = const [],
      this.progressPercentage = 0,
      this.actualQuantity = 0,
      this.goodQuantity = 0,
      this.rejectedQuantity = 0,
      this.allocatedBudget,
      this.actualCost = 0.0,
      required this.createdAt,
      required this.updatedAt,
      required this.createdBy,
      this.updatedBy,
      this.version = 1,
      final Map<String, dynamic> metadata = const {}})
      : _requiredMaterials = requiredMaterials,
        _qualitySpecifications = qualitySpecifications,
        _productionNotes = productionNotes,
        _qualityChecks = qualityChecks,
        _metadata = metadata,
        super._();

  factory _$OfOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfOrderImplFromJson(json);

  /// Unique OF number (Manufacturing Order Number)
  @override
  final String ofNumber;

  /// Human-readable title/description
  @override
  final String title;

  /// Detailed description of the manufacturing requirements
  @override
  final String description;

  /// Client/customer name
  @override
  final String clientName;

  /// Product reference/SKU
  @override
  final String productReference;

  /// Planned quantity to produce
  @override
  final int plannedQuantity;

  /// Unit of measurement (pieces, kg, meters, etc.)
  @override
  final String unit;

  /// Current status in the workflow
  @override
  final OfOrderStatus status;

  /// Priority level
  @override
  final OfOrderPriority priority;

  /// Quality control status
  @override
  @JsonKey()
  final QualityStatus qualityStatus;

  /// Assigned production line/machine
  @override
  final String? productionLine;

  /// Supervisor/lead operator ID
  @override
  final String? supervisorId;

  /// Planned start date
  @override
  final DateTime? plannedStartDate;

  /// Actual start date
  @override
  final DateTime? actualStartDate;

  /// Planned completion date
  @override
  final DateTime? plannedCompletionDate;

  /// Actual completion date
  @override
  final DateTime? actualCompletionDate;

  /// Delivery deadline
  @override
  final DateTime? deliveryDeadline;

  /// Actual delivery date
  @override
  final DateTime? actualDeliveryDate;

  /// Materials required (list of material references)
  final List<String> _requiredMaterials;

  /// Materials required (list of material references)
  @override
  @JsonKey()
  List<String> get requiredMaterials {
    if (_requiredMaterials is EqualUnmodifiableListView)
      return _requiredMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredMaterials);
  }

  /// Quality specifications/checkpoints
  final List<String> _qualitySpecifications;

  /// Quality specifications/checkpoints
  @override
  @JsonKey()
  List<String> get qualitySpecifications {
    if (_qualitySpecifications is EqualUnmodifiableListView)
      return _qualitySpecifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualitySpecifications);
  }

  /// Production notes/progress updates
  final List<ProductionNote> _productionNotes;

  /// Production notes/progress updates
  @override
  @JsonKey()
  List<ProductionNote> get productionNotes {
    if (_productionNotes is EqualUnmodifiableListView) return _productionNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productionNotes);
  }

  /// Quality control results
  final List<QualityCheck> _qualityChecks;

  /// Quality control results
  @override
  @JsonKey()
  List<QualityCheck> get qualityChecks {
    if (_qualityChecks is EqualUnmodifiableListView) return _qualityChecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualityChecks);
  }

  /// Current progress percentage (0-100)
  @override
  @JsonKey()
  final int progressPercentage;

  /// Quantity actually produced
  @override
  @JsonKey()
  final int actualQuantity;

  /// Quantity that passed quality control
  @override
  @JsonKey()
  final int goodQuantity;

  /// Quantity rejected/scrap
  @override
  @JsonKey()
  final int rejectedQuantity;

  /// Budget allocated for this order
  @override
  final double? allocatedBudget;

  /// Actual costs incurred
  @override
  @JsonKey()
  final double actualCost;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// User who created the order
  @override
  final String createdBy;

  /// Last user who updated the order
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
    return 'OfOrder(ofNumber: $ofNumber, title: $title, description: $description, clientName: $clientName, productReference: $productReference, plannedQuantity: $plannedQuantity, unit: $unit, status: $status, priority: $priority, qualityStatus: $qualityStatus, productionLine: $productionLine, supervisorId: $supervisorId, plannedStartDate: $plannedStartDate, actualStartDate: $actualStartDate, plannedCompletionDate: $plannedCompletionDate, actualCompletionDate: $actualCompletionDate, deliveryDeadline: $deliveryDeadline, actualDeliveryDate: $actualDeliveryDate, requiredMaterials: $requiredMaterials, qualitySpecifications: $qualitySpecifications, productionNotes: $productionNotes, qualityChecks: $qualityChecks, progressPercentage: $progressPercentage, actualQuantity: $actualQuantity, goodQuantity: $goodQuantity, rejectedQuantity: $rejectedQuantity, allocatedBudget: $allocatedBudget, actualCost: $actualCost, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, version: $version, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfOrderImpl &&
            (identical(other.ofNumber, ofNumber) ||
                other.ofNumber == ofNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.productReference, productReference) ||
                other.productReference == productReference) &&
            (identical(other.plannedQuantity, plannedQuantity) ||
                other.plannedQuantity == plannedQuantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.qualityStatus, qualityStatus) ||
                other.qualityStatus == qualityStatus) &&
            (identical(other.productionLine, productionLine) ||
                other.productionLine == productionLine) &&
            (identical(other.supervisorId, supervisorId) ||
                other.supervisorId == supervisorId) &&
            (identical(other.plannedStartDate, plannedStartDate) ||
                other.plannedStartDate == plannedStartDate) &&
            (identical(other.actualStartDate, actualStartDate) ||
                other.actualStartDate == actualStartDate) &&
            (identical(other.plannedCompletionDate, plannedCompletionDate) ||
                other.plannedCompletionDate == plannedCompletionDate) &&
            (identical(other.actualCompletionDate, actualCompletionDate) ||
                other.actualCompletionDate == actualCompletionDate) &&
            (identical(other.deliveryDeadline, deliveryDeadline) ||
                other.deliveryDeadline == deliveryDeadline) &&
            (identical(other.actualDeliveryDate, actualDeliveryDate) ||
                other.actualDeliveryDate == actualDeliveryDate) &&
            const DeepCollectionEquality()
                .equals(other._requiredMaterials, _requiredMaterials) &&
            const DeepCollectionEquality()
                .equals(other._qualitySpecifications, _qualitySpecifications) &&
            const DeepCollectionEquality()
                .equals(other._productionNotes, _productionNotes) &&
            const DeepCollectionEquality()
                .equals(other._qualityChecks, _qualityChecks) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.actualQuantity, actualQuantity) ||
                other.actualQuantity == actualQuantity) &&
            (identical(other.goodQuantity, goodQuantity) ||
                other.goodQuantity == goodQuantity) &&
            (identical(other.rejectedQuantity, rejectedQuantity) ||
                other.rejectedQuantity == rejectedQuantity) &&
            (identical(other.allocatedBudget, allocatedBudget) ||
                other.allocatedBudget == allocatedBudget) &&
            (identical(other.actualCost, actualCost) ||
                other.actualCost == actualCost) &&
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
        ofNumber,
        title,
        description,
        clientName,
        productReference,
        plannedQuantity,
        unit,
        status,
        priority,
        qualityStatus,
        productionLine,
        supervisorId,
        plannedStartDate,
        actualStartDate,
        plannedCompletionDate,
        actualCompletionDate,
        deliveryDeadline,
        actualDeliveryDate,
        const DeepCollectionEquality().hash(_requiredMaterials),
        const DeepCollectionEquality().hash(_qualitySpecifications),
        const DeepCollectionEquality().hash(_productionNotes),
        const DeepCollectionEquality().hash(_qualityChecks),
        progressPercentage,
        actualQuantity,
        goodQuantity,
        rejectedQuantity,
        allocatedBudget,
        actualCost,
        createdAt,
        updatedAt,
        createdBy,
        updatedBy,
        version,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of OfOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfOrderImplCopyWith<_$OfOrderImpl> get copyWith =>
      __$$OfOrderImplCopyWithImpl<_$OfOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfOrderImplToJson(
      this,
    );
  }
}

abstract class _OfOrder extends OfOrder {
  const factory _OfOrder(
      {required final String ofNumber,
      required final String title,
      required final String description,
      required final String clientName,
      required final String productReference,
      required final int plannedQuantity,
      required final String unit,
      required final OfOrderStatus status,
      required final OfOrderPriority priority,
      final QualityStatus qualityStatus,
      final String? productionLine,
      final String? supervisorId,
      final DateTime? plannedStartDate,
      final DateTime? actualStartDate,
      final DateTime? plannedCompletionDate,
      final DateTime? actualCompletionDate,
      final DateTime? deliveryDeadline,
      final DateTime? actualDeliveryDate,
      final List<String> requiredMaterials,
      final List<String> qualitySpecifications,
      final List<ProductionNote> productionNotes,
      final List<QualityCheck> qualityChecks,
      final int progressPercentage,
      final int actualQuantity,
      final int goodQuantity,
      final int rejectedQuantity,
      final double? allocatedBudget,
      final double actualCost,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String createdBy,
      final String? updatedBy,
      final int version,
      final Map<String, dynamic> metadata}) = _$OfOrderImpl;
  const _OfOrder._() : super._();

  factory _OfOrder.fromJson(Map<String, dynamic> json) = _$OfOrderImpl.fromJson;

  /// Unique OF number (Manufacturing Order Number)
  @override
  String get ofNumber;

  /// Human-readable title/description
  @override
  String get title;

  /// Detailed description of the manufacturing requirements
  @override
  String get description;

  /// Client/customer name
  @override
  String get clientName;

  /// Product reference/SKU
  @override
  String get productReference;

  /// Planned quantity to produce
  @override
  int get plannedQuantity;

  /// Unit of measurement (pieces, kg, meters, etc.)
  @override
  String get unit;

  /// Current status in the workflow
  @override
  OfOrderStatus get status;

  /// Priority level
  @override
  OfOrderPriority get priority;

  /// Quality control status
  @override
  QualityStatus get qualityStatus;

  /// Assigned production line/machine
  @override
  String? get productionLine;

  /// Supervisor/lead operator ID
  @override
  String? get supervisorId;

  /// Planned start date
  @override
  DateTime? get plannedStartDate;

  /// Actual start date
  @override
  DateTime? get actualStartDate;

  /// Planned completion date
  @override
  DateTime? get plannedCompletionDate;

  /// Actual completion date
  @override
  DateTime? get actualCompletionDate;

  /// Delivery deadline
  @override
  DateTime? get deliveryDeadline;

  /// Actual delivery date
  @override
  DateTime? get actualDeliveryDate;

  /// Materials required (list of material references)
  @override
  List<String> get requiredMaterials;

  /// Quality specifications/checkpoints
  @override
  List<String> get qualitySpecifications;

  /// Production notes/progress updates
  @override
  List<ProductionNote> get productionNotes;

  /// Quality control results
  @override
  List<QualityCheck> get qualityChecks;

  /// Current progress percentage (0-100)
  @override
  int get progressPercentage;

  /// Quantity actually produced
  @override
  int get actualQuantity;

  /// Quantity that passed quality control
  @override
  int get goodQuantity;

  /// Quantity rejected/scrap
  @override
  int get rejectedQuantity;

  /// Budget allocated for this order
  @override
  double? get allocatedBudget;

  /// Actual costs incurred
  @override
  double get actualCost;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// User who created the order
  @override
  String get createdBy;

  /// Last user who updated the order
  @override
  String? get updatedBy;

  /// Version for optimistic concurrency
  @override
  int get version;

  /// Additional metadata
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of OfOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfOrderImplCopyWith<_$OfOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductionNote _$ProductionNoteFromJson(Map<String, dynamic> json) {
  return _ProductionNote.fromJson(json);
}

/// @nodoc
mixin _$ProductionNote {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ProductionNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductionNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductionNoteCopyWith<ProductionNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductionNoteCopyWith<$Res> {
  factory $ProductionNoteCopyWith(
          ProductionNote value, $Res Function(ProductionNote) then) =
      _$ProductionNoteCopyWithImpl<$Res, ProductionNote>;
  @useResult
  $Res call({String id, String content, String authorId, DateTime timestamp});
}

/// @nodoc
class _$ProductionNoteCopyWithImpl<$Res, $Val extends ProductionNote>
    implements $ProductionNoteCopyWith<$Res> {
  _$ProductionNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductionNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductionNoteImplCopyWith<$Res>
    implements $ProductionNoteCopyWith<$Res> {
  factory _$$ProductionNoteImplCopyWith(_$ProductionNoteImpl value,
          $Res Function(_$ProductionNoteImpl) then) =
      __$$ProductionNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String content, String authorId, DateTime timestamp});
}

/// @nodoc
class __$$ProductionNoteImplCopyWithImpl<$Res>
    extends _$ProductionNoteCopyWithImpl<$Res, _$ProductionNoteImpl>
    implements _$$ProductionNoteImplCopyWith<$Res> {
  __$$ProductionNoteImplCopyWithImpl(
      _$ProductionNoteImpl _value, $Res Function(_$ProductionNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductionNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorId = null,
    Object? timestamp = null,
  }) {
    return _then(_$ProductionNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductionNoteImpl implements _ProductionNote {
  const _$ProductionNoteImpl(
      {required this.id,
      required this.content,
      required this.authorId,
      required this.timestamp});

  factory _$ProductionNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductionNoteImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final String authorId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ProductionNote(id: $id, content: $content, authorId: $authorId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductionNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, authorId, timestamp);

  /// Create a copy of ProductionNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductionNoteImplCopyWith<_$ProductionNoteImpl> get copyWith =>
      __$$ProductionNoteImplCopyWithImpl<_$ProductionNoteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductionNoteImplToJson(
      this,
    );
  }
}

abstract class _ProductionNote implements ProductionNote {
  const factory _ProductionNote(
      {required final String id,
      required final String content,
      required final String authorId,
      required final DateTime timestamp}) = _$ProductionNoteImpl;

  factory _ProductionNote.fromJson(Map<String, dynamic> json) =
      _$ProductionNoteImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  String get authorId;
  @override
  DateTime get timestamp;

  /// Create a copy of ProductionNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductionNoteImplCopyWith<_$ProductionNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QualityCheck _$QualityCheckFromJson(Map<String, dynamic> json) {
  return _QualityCheck.fromJson(json);
}

/// @nodoc
mixin _$QualityCheck {
  String get id => throw _privateConstructorUsedError;
  String get checkpoint => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get inspectorId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this QualityCheck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QualityCheck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QualityCheckCopyWith<QualityCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualityCheckCopyWith<$Res> {
  factory $QualityCheckCopyWith(
          QualityCheck value, $Res Function(QualityCheck) then) =
      _$QualityCheckCopyWithImpl<$Res, QualityCheck>;
  @useResult
  $Res call(
      {String id,
      String checkpoint,
      bool passed,
      String? notes,
      String inspectorId,
      DateTime timestamp});
}

/// @nodoc
class _$QualityCheckCopyWithImpl<$Res, $Val extends QualityCheck>
    implements $QualityCheckCopyWith<$Res> {
  _$QualityCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QualityCheck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checkpoint = null,
    Object? passed = null,
    Object? notes = freezed,
    Object? inspectorId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      checkpoint: null == checkpoint
          ? _value.checkpoint
          : checkpoint // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      inspectorId: null == inspectorId
          ? _value.inspectorId
          : inspectorId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QualityCheckImplCopyWith<$Res>
    implements $QualityCheckCopyWith<$Res> {
  factory _$$QualityCheckImplCopyWith(
          _$QualityCheckImpl value, $Res Function(_$QualityCheckImpl) then) =
      __$$QualityCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String checkpoint,
      bool passed,
      String? notes,
      String inspectorId,
      DateTime timestamp});
}

/// @nodoc
class __$$QualityCheckImplCopyWithImpl<$Res>
    extends _$QualityCheckCopyWithImpl<$Res, _$QualityCheckImpl>
    implements _$$QualityCheckImplCopyWith<$Res> {
  __$$QualityCheckImplCopyWithImpl(
      _$QualityCheckImpl _value, $Res Function(_$QualityCheckImpl) _then)
      : super(_value, _then);

  /// Create a copy of QualityCheck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checkpoint = null,
    Object? passed = null,
    Object? notes = freezed,
    Object? inspectorId = null,
    Object? timestamp = null,
  }) {
    return _then(_$QualityCheckImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      checkpoint: null == checkpoint
          ? _value.checkpoint
          : checkpoint // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      inspectorId: null == inspectorId
          ? _value.inspectorId
          : inspectorId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualityCheckImpl implements _QualityCheck {
  const _$QualityCheckImpl(
      {required this.id,
      required this.checkpoint,
      required this.passed,
      this.notes,
      required this.inspectorId,
      required this.timestamp});

  factory _$QualityCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualityCheckImplFromJson(json);

  @override
  final String id;
  @override
  final String checkpoint;
  @override
  final bool passed;
  @override
  final String? notes;
  @override
  final String inspectorId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'QualityCheck(id: $id, checkpoint: $checkpoint, passed: $passed, notes: $notes, inspectorId: $inspectorId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityCheckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.checkpoint, checkpoint) ||
                other.checkpoint == checkpoint) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.inspectorId, inspectorId) ||
                other.inspectorId == inspectorId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, checkpoint, passed, notes, inspectorId, timestamp);

  /// Create a copy of QualityCheck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityCheckImplCopyWith<_$QualityCheckImpl> get copyWith =>
      __$$QualityCheckImplCopyWithImpl<_$QualityCheckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualityCheckImplToJson(
      this,
    );
  }
}

abstract class _QualityCheck implements QualityCheck {
  const factory _QualityCheck(
      {required final String id,
      required final String checkpoint,
      required final bool passed,
      final String? notes,
      required final String inspectorId,
      required final DateTime timestamp}) = _$QualityCheckImpl;

  factory _QualityCheck.fromJson(Map<String, dynamic> json) =
      _$QualityCheckImpl.fromJson;

  @override
  String get id;
  @override
  String get checkpoint;
  @override
  bool get passed;
  @override
  String? get notes;
  @override
  String get inspectorId;
  @override
  DateTime get timestamp;

  /// Create a copy of QualityCheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QualityCheckImplCopyWith<_$QualityCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
