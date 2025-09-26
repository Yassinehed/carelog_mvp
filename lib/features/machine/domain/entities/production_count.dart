import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_count.freezed.dart';
part 'production_count.g.dart';

@freezed
class ProductionCount with _$ProductionCount {
  const factory ProductionCount({
    required String id,
    required int count,
    DateTime? timestamp,
  }) = _ProductionCount;

  factory ProductionCount.fromJson(Map<String, dynamic> json) => _$ProductionCountFromJson(json);
}
