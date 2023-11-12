import 'package:json_annotation/json_annotation.dart';

part 'stopwatch_record.g.dart';

@JsonSerializable()
class StopwatchRecord {
  final String userId;
  final String id;
  final String? name;
  final String? duration;
  final int? lapsCount;

  StopwatchRecord({
    required this.userId,
    required this.name,
    required this.duration,
    required this.lapsCount,
    required this.id,
  });
  factory StopwatchRecord.fromJson(Map<String, dynamic> json) =>
      _$StopwatchRecordFromJson(json);

  Map<String, dynamic> toJson() => _$StopwatchRecordToJson(this);
}
