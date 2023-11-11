import 'package:flutter/material.dart';

class TimerBox extends StatelessWidget {
  final String time;

  const TimerBox({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xFFD1C4E9),
          Color(0xFFBBDEFB),
        ]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(time, style: const TextStyle(fontSize: 40)),
    );
  }
}
