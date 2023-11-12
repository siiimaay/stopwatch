import 'package:stopwatch/features/stopwatch/data/models/stopwatch_record.dart';

abstract class FirestoreService {
  Future<void> saveRecord();

  Future<void> deleteRecord({String? id});

  Future<void> renameRecord();

  Future<List<StopwatchRecord>> fetchRecords();
}
