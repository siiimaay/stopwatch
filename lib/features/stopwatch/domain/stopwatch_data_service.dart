import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/core/service/firestore_service.dart';
import 'package:stopwatch/features/stopwatch/data/models/stopwatch_record.dart';
import 'package:uuid/uuid.dart';

class StopWatchStorageService implements FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('stopwatchRecords');

  @override
  Future<void> deleteRecord() {
    // TODO: implement deleteRecord
    throw UnimplementedError();
  }

  @override
  Future<List<StopwatchRecord>> fetchRecords() {
    List<StopwatchRecord> stopwatches = [];
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw 'User id must not be null';

    return FirebaseFirestore.instance
        .collection('stopwatchRecords')
        .where('userId', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        stopwatches.add(StopwatchRecord.fromJson(data));
      }

      return stopwatches;
    });
  }

  @override
  Future<void> renameRecord() {
    // TODO: implement renameRecord
    throw UnimplementedError();
  }

  @override
  Future<void> saveRecord({
    String? name = 'Default',
    String? duration = '',
    int? lapsCount = 0,
  }) async {
    final stopwatchRecords = StopwatchRecord(
      id: const Uuid().v4(),
      name: name!,
      duration: duration!,
      lapsCount: lapsCount!,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ).toJson();
    await _firebaseFirestore
        .collection('stopwatchRecords')
        .doc()
        .set(stopwatchRecords);
  }
}
