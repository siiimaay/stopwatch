import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class StopwatchBloc extends Bloc<StopWatchEvent, StopwatchState> {
  Timer? _timer;

  StopwatchBloc()
      : super(const StopwatchState(Duration.zero, [], false, false, false));

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      add(StartEvent());
    });
  }

  void stop() => add(StopEvent());

  void reset() => add(ResetEvent());

  void lap() => add(LapEvent());

  void confirmSave() => add(ConfirmSave());

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
      );
    } else if (event is StopEvent) {
      _timer?.cancel();
      yield state.copyWith(
        isRunning: false,
        shouldAskForSave: true,
      );
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

class SaveEvent extends StopWatchEvent {}

class StopwatchState {
  final Duration duration;
  final List<Duration> laps;
  final bool isRunning;
  final bool shouldAskForSave;
  final bool shouldMoveToSave;

  const StopwatchState(
    this.duration,
    this.laps,
    this.isRunning,
    this.shouldAskForSave,
    this.shouldMoveToSave,
  );

  StopwatchState copyWith({
    Duration? duration,
    List<Duration>? laps,
    bool? isRunning,
    bool? shouldAskForSave,
    bool? shouldMoveToSave,
  }) {
    return StopwatchState(
      duration ?? this.duration,
      laps ?? this.laps,
      isRunning ?? this.isRunning,
      shouldAskForSave ?? this.shouldAskForSave,
      shouldMoveToSave ?? this.shouldMoveToSave,
    );
  }
}
