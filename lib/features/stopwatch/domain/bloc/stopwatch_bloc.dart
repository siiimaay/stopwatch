import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class StopwatchBloc extends Bloc<StopWatchEvent, StopwatchState> {
  late Timer _timer;

  StopwatchBloc()
      : super(const StopwatchState(Duration.zero, [], false, false));

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      add(StartEvent());
    });
  }

  void stop() => add(StopEvent());

  void reset() => add(ResetEvent());

  void lap() => add(LapEvent());

  @override
  Stream<StopwatchState> mapEventToState(StopWatchEvent event) async* {
    if (event is StartEvent) {
      yield state.copyWith(
          isRunning: true,
          duration: Duration(
            milliseconds: 1 + state.duration.inMilliseconds,
          ));
    } else if (event is StopEvent) {
      _timer.cancel();
      yield state.copyWith(isRunning: false);
    } else if (event is ResetEvent) {
      yield state.copyWith(
        duration: Duration.zero,
        laps: [],
      );
    } else if (event is LapEvent) {
      final lapList = List.from(state.laps);
      lapList.add(state.duration);
      yield state.copyWith(laps: [...lapList]);
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}

sealed class StopWatchEvent {}

class StartEvent extends StopWatchEvent {}

class StopEvent extends StopWatchEvent {}

class ResetEvent extends StopWatchEvent {}

class LapEvent extends StopWatchEvent {}

class StopwatchState {
  final Duration duration;
  final List<Duration> laps;
  final bool isRunning;
  final bool shouldAskForSave;

  const StopwatchState(
      this.duration, this.laps, this.isRunning, this.shouldAskForSave);

  StopwatchState copyWith({
    Duration? duration,
    List<Duration>? laps,
    bool? isRunning,
    bool? shouldAskForSave,
  }) {
    return StopwatchState(
      duration ?? this.duration,
      laps ?? this.laps,
      isRunning ?? this.isRunning,
      shouldAskForSave ?? this.shouldAskForSave,
    );
  }
}