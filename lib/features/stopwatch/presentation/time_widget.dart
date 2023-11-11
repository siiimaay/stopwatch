import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/features/stopwatch/domain/bloc/stopwatch_bloc.dart';
import 'package:stopwatch/features/stopwatch/presentation/timer_box.dart';

class TimeWidgetBlocBuilder extends StatelessWidget {
  const TimeWidgetBlocBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchBloc, StopwatchState>(
        buildWhen: (oldState, newState) =>
            oldState.duration != newState.duration,
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBox(
                time: state.duration.inMinutes
                    .remainder(60)
                    .toString()
                    .padLeft(2, '0'),
              ),
              TimerBox(
                time: state.duration.inSeconds.toString().padLeft(2, '0'),
              ),
              TimerBox(
                time: (state.duration.inMilliseconds % 60)
                    .toString()
                    .padLeft(2, '0'),
              )
            ],
          );
        });
  }
}
