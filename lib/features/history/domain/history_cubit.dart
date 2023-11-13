import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/features/stopwatch/data/models/stopwatch_record.dart';
import 'package:stopwatch/features/stopwatch/data/repository/stopwatch_repository.dart';

import '../../../core/injection/locator.dart';

class HistoryCubit extends Cubit<HistoryState> {
  late final StopwatchRepository repository;

  HistoryCubit() : super(HistoryState()) {
    repository = getIt<StopwatchRepository>();
    _init();
  }

  _init() async {
    emit(state.copyWith(isLoading: true));
    final stopwatchRecords = await repository.fetchStopwatchRecords();
    emit(state.copyWith(stopwatchList: stopwatchRecords, isLoading: false));
  }

  Future<void> deleteRecord(String? recordId) async {
    if (recordId == null) throw 'Id must not be null';
    await repository.deleteStopwatch(recordId);
  }
}

class HistoryState {
  final List<StopwatchRecord> stopwatchList;
  final bool isLoading;

  HistoryState({
    this.stopwatchList = const [],
    this.isLoading = false,
  });

  HistoryState copyWith(
      {List<StopwatchRecord>? stopwatchList, bool? isLoading}) {
    return HistoryState(
      stopwatchList: stopwatchList ?? this.stopwatchList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
