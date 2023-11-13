import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/history/data/history_detail.dart';
import 'package:stopwatch/routes/route_config.dart';

import '../domain/history_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryCubit>(
      create: (context) => HistoryCubit(),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          final stopwatchList = state.stopwatchList;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.indigoAccent,
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            color: const Color(0xfff9f9f9),
            child: ListView.builder(
              itemCount: stopwatchList.length,
              itemBuilder: (context, index) {
                final savedStopwatch = stopwatchList[index];
                return InkWell(
                  onTap: () async {
                    var lapList = savedStopwatch.laps;
                    var duration = savedStopwatch.duration;
                    context.pushNamed(
                      AppRouter.historyDetailRoute,
                      extra: HistoryDetail(
                          duration: duration,
                          laps: lapList,
                          name: savedStopwatch.name,
                          onDelete: () async {
                            await context
                                .read<HistoryCubit>()
                                .deleteRecord(savedStopwatch.id);
                          }),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    elevation: 1,
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () async {
                          await context
                              .read<HistoryCubit>()
                              .deleteRecord(savedStopwatch.id);
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              await context
                                  .read<HistoryCubit>()
                                  .deleteRecord(savedStopwatch.id);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.av_timer_outlined,
                          color: Colors.indigo,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.indigo,
                        ),
                        title: Text(
                          savedStopwatch.name ?? 'Default',
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          '# of laps: ${savedStopwatch.laps.length.toString()}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
