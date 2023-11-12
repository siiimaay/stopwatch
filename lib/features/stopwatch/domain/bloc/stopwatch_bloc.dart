import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/core/extensions/duration_extension.dart';
import 'package:stopwatch/core/injection/locator.dart';
import 'package:stopwatch/features/stopwatch/data/repository/stopwatch_repository.dart';

class StopwatchBloc extends Bloc<StopWatchEvent, StopwatchState> {
  Timer? _timer;
  StopwatchRepository? stopwatchRepository;

  StopwatchBloc() : super(const StopwatchState()) {
    stopwatchRepository = getIt<StopwatchRepository>();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      add(StartEvent());
    });
  }

  void stop() => add(StopEvent());

  void reset() => add(ResetEvent());

  void lap() => add(LapEvent());

  void confirmSave() => add(ConfirmSave());

  Future<void> save(String name) async {
    List<String> lapsList = List.empty(growable: true);
    try {
      for (var element in state.laps) {
        lapsList.add(element.formatDurationAsText());
      }

      await stopwatchRepository?.saveStopwatch(name.isEmpty ? 'Default' : name,
          state.duration.formatDurationAsText(), lapsList);
      add(SaveEvent());
    } catch (e) {
      add(ErrorEvent());
    }
  }

  @override
  Stream<StopwatchState> mapEventToState(StopWatchEvent event) async* {
    if (event is StartEvent) {
      yield state.copyWith(
        isRunning: true,
        duration: Duration(
          milliseconds: 1 + state.duration.inMilliseconds,
        ),
        shouldAskForSave: false,
        shouldMoveToSave: false,
        hasSaveCompleted: false,
      );
    } else if (event is StopEvent) {
      _timer?.cancel();
      yield state.copyWith(
          isRunning: false, shouldAskForSave: true, laps: state.laps);
    } else if (event is ResetEvent) {
      yield state.copyWith(
        duration: Duration.zero,
        laps: [],
      );
    } else if (event is LapEvent) {
      final lapList = List.from(state.laps);
      lapList.add(state.duration);
      yield state.copyWith(laps: [...lapList]);
    } else if (event is ConfirmSave) {
      yield state.copyWith(shouldMoveToSave: true, shouldAskForSave: false);
    } else if (event is SaveEvent) {
      yield state.copyWith(
        hasSaveCompleted: true,
        shouldAskForSave: false,
        shouldMoveToSave: false,
      );
    }
  }

  @override
  Future<void> close() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    return super.close();
  }
}

sealed class StopWatchEvent {}

class StartEvent extends StopWatchEvent {}

class StopEvent extends StopWatchEvent {}

class ResetEvent extends StopWatchEvent {}

class LapEvent extends StopWatchEvent {}

class ConfirmSave extends StopWatchEvent {}

class ErrorEvent extends StopWatchEvent {}

class SaveEvent extends StopWatchEvent {}

class StopwatchState {
  final Duration duration;
  final List<Duration> laps;
  final bool isRunning;
  final bool shouldAskForSave;
  final bool shouldMoveToSave;
  final bool hasSaveCompleted;

  const StopwatchState({
    this.duration = Duration.zero,
    this.laps = const [],
    this.isRunning = false,
    this.shouldAskForSave = false,
    this.shouldMoveToSave = false,
    this.hasSaveCompleted = false,
  });

  StopwatchState copyWith({
    Duration? duration,
    List<Duration>? laps,
    bool? isRunning,
    bool? shouldAskForSave,
    bool? shouldMoveToSave,
    bool? hasSaveCompleted,
  }) {
    return StopwatchState(
      duration: duration ?? this.duration,
      laps: laps ?? this.laps,
      isRunning: isRunning ?? this.isRunning,
      hasSaveCompleted: hasSaveCompleted ?? this.hasSaveCompleted,
      shouldMoveToSave: shouldMoveToSave ?? this.shouldMoveToSave,
      shouldAskForSave: shouldAskForSave ?? this.shouldAskForSave,
    );
  }
}
