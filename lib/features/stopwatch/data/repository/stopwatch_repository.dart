import 'package:stopwatch/core/injection/locator.dart';
import 'package:stopwatch/features/stopwatch/data/models/stopwatch_record.dart';
import 'package:stopwatch/features/stopwatch/domain/stopwatch_data_service.dart';

class StopwatchRepository {
  static StopwatchRepository? _instance;
  late final StopWatchStorageService _stopwatchStorageService;

  StopwatchRepository._() {
    _stopwatchStorageService = getIt<StopWatchStorageService>();
  }

  factory StopwatchRepository() {
    return _instance ??= StopwatchRepository._();
  }

  Future<List<StopwatchRecord>> fetchStopwatchRecords() async {
    return await _stopwatchStorageService.fetchRecords();
  }

  Future<void> deleteStopwatch() async {
    await _stopwatchStorageService.deleteRecord();
  }

  Future<void> saveStopwatch(
      String name, String duration, int lapsCount) async {
    await _stopwatchStorageService.saveRecord(
      name: name,
      duration: duration,
      lapsCount: lapsCount,
    );
  }
}
