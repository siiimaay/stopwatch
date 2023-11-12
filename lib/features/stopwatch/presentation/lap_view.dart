import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/bloc/stopwatch_bloc.dart';
import 'lap_detail.dart';

class LapViewBlocBuilder extends StatelessWidget {
  const LapViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchBloc, StopwatchState>(
      buildWhen: (oldState, newState) => oldState.laps != newState.laps,
      builder: (context, state) {
        final laps = state.laps;
        return ListView.builder(
            itemCount: laps.length,
            itemBuilder: (context, index) {
              final lap = laps[index];
              return LapDetail(
                  title: "Lap $index",
                  duration:
                      '${lap.inMinutes.remainder(60).toString().padLeft(2, '0')}'
                      ':${lap.inSeconds.toString().padLeft(2, '0')}'
                      ':${(lap.inMilliseconds % 60).toString().padLeft(2, '0')}');
            });
      },
    );
  }
}
