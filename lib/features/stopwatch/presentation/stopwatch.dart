import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/features/stopwatch/presentation/lap_view.dart';
import 'package:stopwatch/features/stopwatch/presentation/time_widget.dart';

import '../domain/bloc/stopwatch_bloc.dart';

class StopWatchView extends StatelessWidget {
  const StopWatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchBloc(),
      child: StopWatchBody(
        stopwatchBloc: StopwatchBloc(),
      ),
    );
  }
}

class StopWatchBody extends StatelessWidget {
  final StopwatchBloc stopwatchBloc;

  const StopWatchBody({super.key, required this.stopwatchBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Stopwatch",
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
          ),
          elevation: 0.8,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFD1C4E9),
              Color(0xFFBBDEFB),
            ])),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TimeWidgetBlocBuilder(),
            const SizedBox(height: 20),
            const StopWatchActions(),
            const SizedBox(height: 20),
            Expanded(
              child: LapViewBlocBuilder(
                bloc: stopwatchBloc,
              ),
            ),
          ],
        ));
  }
}

class StopWatchActions extends StatelessWidget {
  const StopWatchActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchBloc, StopwatchState>(
        buildWhen: (oldState, newState) =>
            oldState.isRunning != newState.isRunning,
        builder: (context, state) {
          final isTimerRunning = state.isRunning;
          return Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => !isTimerRunning
                      ? context.read<StopwatchBloc>().startTimer()
                      : context.read<StopwatchBloc>().stop(),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  child: Text(isTimerRunning ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => !isTimerRunning
                      ? context.read<StopwatchBloc>().reset()
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isTimerRunning ? Colors.grey : Colors.indigo),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => isTimerRunning
                      ? context.read<StopwatchBloc>().lap()
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !isTimerRunning ? Colors.grey : Colors.indigo),
                  child: const Text('Lap'),
                ),
              ],
            ),
          );
        });
  }
}
