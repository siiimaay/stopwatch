import 'package:flutter/material.dart';

class LapDetail extends StatelessWidget {
  final String title;
  final String duration;

  const LapDetail({Key? key, required this.title, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
          ),
          Text(duration)
        ],
      ),
    );
  }
}
