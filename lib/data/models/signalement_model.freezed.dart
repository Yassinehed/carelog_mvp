// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signalement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Signalement _$SignalementFromJson(Map<String, dynamic> json) {
  return _Signalement.fromJson(json);
}

/// @nodoc
mixin _$Signalement {
  /// Unique identifier for the signalement
  String get id => throw _privateConstructorUsedError;

  /// Title/summary of the issue (max 200 chars)
  String get title => throw _privateConstructorUsedError;

  /// Detailed description of the issue
  String get description => throw _privateConstructorUsedError;

  /// Priority level of the signalement
  SignalementPriority get priority => throw _privateConstructorUsedError;

  /// Current status in the workflow
  SignalementStatus get status => throw _privateConstructorUsedError;

  /// Category classification
  SignalementCategory get category => throw _privateConstructorUsedError;

  /// ID of the user who created the signalement
  String get createdBy => throw _privateConstructorUsedError;

  /// ID of the user currently assigned (nullable)
  String? get assignedTo => throw _privateConstructorUsedError;

  /// Associated OF (Manufacturing Order) number
  String? get ofNumber => throw _privateConstructorUsedError;

  /// Location where the issue occurred
  String? get location => throw _privateConstructorUsedError;

  /// Equipment involved (if applicable)
  String? get equipment => throw _privateConstructorUsedError;

  /// Material batch/lot involved (if applicable)
  String? get materialBatch => throw _privateConstructorUsedError;

  /// Expected resolution date
  DateTime? get expectedResolutionDate => throw _privateConstructorUsedError;

  /// Actual resolution date
  DateTime? get actualResolutionDate => throw _privateConstructorUsedError;

  /// Resolution notes/comments
  String? get resolutionNotes => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Version for optimistic concurrency
  int get version => throw _privateConstructorUsedError;

  /// Additional metadata as key-value pairs
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Signalement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
      String title,
      String description,
      SignalementPriority priority,
      SignalementStatus status,
      SignalementCategory category,
      String createdBy,
      String? assignedTo,
      String? ofNumber,
      String? location,
      String? equipment,
      String? materialBatch,
      DateTime? expectedResolutionDate,
      DateTime? actualResolutionDate,
      String? resolutionNotes,
      DateTime createdAt,
      DateTime updatedAt,
      int version,
      Map<String, dynamic> metadata});
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
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? category = null,
    Object? createdBy = null,
    Object? assignedTo = freezed,
    Object? ofNumber = freezed,
    Object? location = freezed,
    Object? equipment = freezed,
    Object? materialBatch = freezed,
    Object? expectedResolutionDate = freezed,
    Object? actualResolutionDate = freezed,
    Object? resolutionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SignalementPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalementStatus,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SignalementCategory,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      ofNumber: freezed == ofNumber
          ? _value.ofNumber
          : ofNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      materialBatch: freezed == materialBatch
          ? _value.materialBatch
          : materialBatch // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResolutionDate: freezed == expectedResolutionDate
          ? _value.expectedResolutionDate
          : expectedResolutionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualResolutionDate: freezed == actualResolutionDate
          ? _value.actualResolutionDate
          : actualResolutionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$SignalementImplCopyWith<$Res>
    implements $SignalementCopyWith<$Res> {
  factory _$$SignalementImplCopyWith(
          _$SignalementImpl value, $Res Function(_$SignalementImpl) then) =
      __$$SignalementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      SignalementPriority priority,
      SignalementStatus status,
      SignalementCategory category,
      String createdBy,
      String? assignedTo,
      String? ofNumber,
      String? location,
      String? equipment,
      String? materialBatch,
      DateTime? expectedResolutionDate,
      DateTime? actualResolutionDate,
      String? resolutionNotes,
      DateTime createdAt,
      DateTime updatedAt,
      int version,
      Map<String, dynamic> metadata});
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
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? category = null,
    Object? createdBy = null,
    Object? assignedTo = freezed,
    Object? ofNumber = freezed,
    Object? location = freezed,
    Object? equipment = freezed,
    Object? materialBatch = freezed,
    Object? expectedResolutionDate = freezed,
    Object? actualResolutionDate = freezed,
    Object? resolutionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
    Object? metadata = null,
  }) {
    return _then(_$SignalementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as SignalementPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalementStatus,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SignalementCategory,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      ofNumber: freezed == ofNumber
          ? _value.ofNumber
          : ofNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      materialBatch: freezed == materialBatch
          ? _value.materialBatch
          : materialBatch // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResolutionDate: freezed == expectedResolutionDate
          ? _value.expectedResolutionDate
          : expectedResolutionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualResolutionDate: freezed == actualResolutionDate
          ? _value.actualResolutionDate
          : actualResolutionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$SignalementImpl extends _Signalement {
  const _$SignalementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.status,
      required this.category,
      required this.createdBy,
      this.assignedTo,
      this.ofNumber,
      this.location,
      this.equipment,
      this.materialBatch,
      this.expectedResolutionDate,
      this.actualResolutionDate,
      this.resolutionNotes,
      required this.createdAt,
      required this.updatedAt,
      this.version = 1,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata,
        super._();

  factory _$SignalementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignalementImplFromJson(json);

  /// Unique identifier for the signalement
  @override
  final String id;

  /// Title/summary of the issue (max 200 chars)
  @override
  final String title;

  /// Detailed description of the issue
  @override
  final String description;

  /// Priority level of the signalement
  @override
  final SignalementPriority priority;

  /// Current status in the workflow
  @override
  final SignalementStatus status;

  /// Category classification
  @override
  final SignalementCategory category;

  /// ID of the user who created the signalement
  @override
  final String createdBy;

  /// ID of the user currently assigned (nullable)
  @override
  final String? assignedTo;

  /// Associated OF (Manufacturing Order) number
  @override
  final String? ofNumber;

  /// Location where the issue occurred
  @override
  final String? location;

  /// Equipment involved (if applicable)
  @override
  final String? equipment;

  /// Material batch/lot involved (if applicable)
  @override
  final String? materialBatch;

  /// Expected resolution date
  @override
  final DateTime? expectedResolutionDate;

  /// Actual resolution date
  @override
  final DateTime? actualResolutionDate;

  /// Resolution notes/comments
  @override
  final String? resolutionNotes;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// Version for optimistic concurrency
  @override
  @JsonKey()
  final int version;

  /// Additional metadata as key-value pairs
  final Map<String, dynamic> _metadata;

  /// Additional metadata as key-value pairs
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Signalement(id: $id, title: $title, description: $description, priority: $priority, status: $status, category: $category, createdBy: $createdBy, assignedTo: $assignedTo, ofNumber: $ofNumber, location: $location, equipment: $equipment, materialBatch: $materialBatch, expectedResolutionDate: $expectedResolutionDate, actualResolutionDate: $actualResolutionDate, resolutionNotes: $resolutionNotes, createdAt: $createdAt, updatedAt: $updatedAt, version: $version, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.ofNumber, ofNumber) ||
                other.ofNumber == ofNumber) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.materialBatch, materialBatch) ||
                other.materialBatch == materialBatch) &&
            (identical(other.expectedResolutionDate, expectedResolutionDate) ||
                other.expectedResolutionDate == expectedResolutionDate) &&
            (identical(other.actualResolutionDate, actualResolutionDate) ||
                other.actualResolutionDate == actualResolutionDate) &&
            (identical(other.resolutionNotes, resolutionNotes) ||
                other.resolutionNotes == resolutionNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        priority,
        status,
        category,
        createdBy,
        assignedTo,
        ofNumber,
        location,
        equipment,
        materialBatch,
        expectedResolutionDate,
        actualResolutionDate,
        resolutionNotes,
        createdAt,
        updatedAt,
        version,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignalementImplCopyWith<_$SignalementImpl> get copyWith =>
      __$$SignalementImplCopyWithImpl<_$SignalementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignalementImplToJson(
      this,
    );
  }
}

abstract class _Signalement extends Signalement {
  const factory _Signalement(
      {required final String id,
      required final String title,
      required final String description,
      required final SignalementPriority priority,
      required final SignalementStatus status,
      required final SignalementCategory category,
      required final String createdBy,
      final String? assignedTo,
      final String? ofNumber,
      final String? location,
      final String? equipment,
      final String? materialBatch,
      final DateTime? expectedResolutionDate,
      final DateTime? actualResolutionDate,
      final String? resolutionNotes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final int version,
      final Map<String, dynamic> metadata}) = _$SignalementImpl;
  const _Signalement._() : super._();

  factory _Signalement.fromJson(Map<String, dynamic> json) =
      _$SignalementImpl.fromJson;

  /// Unique identifier for the signalement
  @override
  String get id;

  /// Title/summary of the issue (max 200 chars)
  @override
  String get title;

  /// Detailed description of the issue
  @override
  String get description;

  /// Priority level of the signalement
  @override
  SignalementPriority get priority;

  /// Current status in the workflow
  @override
  SignalementStatus get status;

  /// Category classification
  @override
  SignalementCategory get category;

  /// ID of the user who created the signalement
  @override
  String get createdBy;

  /// ID of the user currently assigned (nullable)
  @override
  String? get assignedTo;

  /// Associated OF (Manufacturing Order) number
  @override
  String? get ofNumber;

  /// Location where the issue occurred
  @override
  String? get location;

  /// Equipment involved (if applicable)
  @override
  String? get equipment;

  /// Material batch/lot involved (if applicable)
  @override
  String? get materialBatch;

  /// Expected resolution date
  @override
  DateTime? get expectedResolutionDate;

  /// Actual resolution date
  @override
  DateTime? get actualResolutionDate;

  /// Resolution notes/comments
  @override
  String? get resolutionNotes;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// Version for optimistic concurrency
  @override
  int get version;

  /// Additional metadata as key-value pairs
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Signalement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignalementImplCopyWith<_$SignalementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
