import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/core/injection/locator.dart';
import 'package:stopwatch/features/auth/domain/login_service.dart';
import 'package:stopwatch/features/stopwatch/data/models/headers.dart';
import 'package:stopwatch/features/stopwatch/presentation/lap_view.dart';
import 'package:stopwatch/features/stopwatch/presentation/time_widget.dart';
import 'package:stopwatch/routes/route_config.dart';
import 'package:stopwatch/widgets/confirmation_dialog.dart';
import 'package:stopwatch/widgets/snackbar.dart';

import '../../history/presentation/history_view.dart';
import '../domain/bloc/stopwatch_bloc.dart';

class StopWatchAppView extends StatefulWidget {
  const StopWatchAppView({Key? key}) : super(key: key);

  @override
  State<StopWatchAppView> createState() => _StopWatchAppViewState();
}

class _StopWatchAppViewState extends State<StopWatchAppView> {
  int _pageIndex = 0;

  List<Widget> screens = [
    const StopWatchBody(),
    const HistoryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Headers.values[_pageIndex].name,
          style: const TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                getIt<LoginService>()
                    .signOut()
                    .whenComplete(() => context.goNamed(AppRouter.loginRoute));
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
        elevation: 0.8,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFD1C4E9),
            Color(0xFFBBDEFB),
          ])),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFD1C4E9),
          Color(0xFFBBDEFB),
        ])),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          fixedColor: Colors.indigo,
          unselectedLabelStyle: const TextStyle(color: Colors.indigo),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.timer,
              ),
              label: 'Stopwatch',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'History',
            ),
          ],
        ),
      ),
      body: screens[_pageIndex],
    );
  }
}

class StopWatchBody extends StatelessWidget {
  const StopWatchBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchBloc(),
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TimeWidgetBlocBuilder(),
            const SizedBox(height: 20),
            StopWatchActions(
              bloc: context.read<StopwatchBloc>(),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: LapViewBlocBuilder(),
            ),
          ],
        );
      }),
    );
  }
}

class StopWatchActions extends StatelessWidget {
  final StopwatchBloc bloc;

  StopWatchActions({super.key, required this.bloc});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StopwatchBloc, StopwatchState>(
        listenWhen: (oldState, newState) =>
            oldState.isRunning != newState.isRunning ||
            oldState.shouldAskForSave != newState.shouldAskForSave ||
            oldState.shouldMoveToSave != newState.shouldMoveToSave ||
            oldState.hasSaveCompleted != newState.hasSaveCompleted,
        listener: (context, state) {
          if (state.shouldAskForSave) {
            showDialog(
              barrierColor: Colors.white.withOpacity(0),
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  title: 'Do you want to save this record?',
                  onConfirm: () async {
                    GoRouter.of(context).pop();
                    bloc.confirmSave();
                  },
                  child: const Text(
                      "Save your time record to see your activities!"),
                );
              },
            );
          } else if (state.shouldMoveToSave) {
            showDialog(
              barrierColor: Colors.white.withOpacity(0),
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  title: 'Please name your stopwatch.',
                  onConfirm: () async {
                    GoRouter.of(context).pop();
                    await bloc.save(textEditingController.text);
                    textEditingController.clear();
                  },
                  onCancel: () {
                    textEditingController.clear();
                  },
                  child: TextField(
                    controller: textEditingController,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state.hasSaveCompleted) {
            TopSnackBarOverlay.showTopSnackbar(
              context: context,
              message: 'Successfully saved!',
              backgroundColor: Colors.green,
              icon: Icons.done,
            );
          }
        },
        buildWhen: (oldState, newState) =>
            oldState.isRunning != newState.isRunning ||
            oldState.shouldAskForSave != newState.shouldAskForSave ||
            oldState.shouldMoveToSave != newState.shouldMoveToSave,
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
