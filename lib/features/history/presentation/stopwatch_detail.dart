import 'package:flutter/material.dart';
import 'package:stopwatch/features/stopwatch/presentation/lap_detail.dart';

import '../../../widgets/popup_menu.dart';
import '../../stopwatch/presentation/timer_box.dart';

class StopwatchDetailView extends StatelessWidget {
  final String duration;
  final List<String> laps;
  final String? name;
  final Function()? onDelete;

  const StopwatchDetailView({
    Key? key,
    required this.duration,
    required this.laps,
    required this.name,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About: $name',
          style: const TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.w500),
        ),
        actions: [MenuItemPopup(onDelete: onDelete)],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBox(
                time: duration,
              ),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: laps.length,
              itemBuilder: (context, index) {
                final lapDuration = laps[index];
                return LapDetail(title: "Lap $index", duration: lapDuration);
              })
        ],
      ),
    );
  }
}
