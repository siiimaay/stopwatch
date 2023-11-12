import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/core/service/firestore_service.dart';
import 'package:stopwatch/features/stopwatch/data/models/stopwatch_record.dart';
import 'package:uuid/uuid.dart';

class StopWatchStorageService implements FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('stopwatchRecords');

  @override
  Future<void> deleteRecord({String? id}) async {
    try {
      await _collection.doc('$id').delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<StopwatchRecord>> fetchRecords() {
    List<StopwatchRecord> stopwatches = [];
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw 'User id must not be null';

    return _collection
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
    List<String>? laps,
  }) async {
    final id = const Uuid().v4();
    print(laps);
    final stopwatchRecords = StopwatchRecord(
      id: id,
      name: name!,
      duration: duration!,
      userId: FirebaseAuth.instance.currentUser!.uid,
      laps: laps ?? [],
    ).toJson();
    await _firebaseFirestore
        .collection('stopwatchRecords')
        .doc(id)
        .set(stopwatchRecords);
  }
}
