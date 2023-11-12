import 'package:json_annotation/json_annotation.dart';

part 'stopwatch_record.g.dart';

@JsonSerializable()
class StopwatchRecord {
  final String userId;
  final String id;
  final String? name;
  final String? duration;
  final List<String> laps;

  StopwatchRecord({
    required this.userId,
    required this.duration,
    required this.id,
    this.laps = const [],
    this.name = 'Default',
  });
  factory StopwatchRecord.fromJson(Map<String, dynamic> json) =>
      _$StopwatchRecordFromJson(json);

  Map<String, dynamic> toJson() => _$StopwatchRecordToJson(this);
}
