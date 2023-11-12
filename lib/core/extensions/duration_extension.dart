extension DurationExtension on Duration {
  String formatDurationAsText() {
    return '${inMinutes.remainder(60).toString().padLeft(2, '0')}'
        ':${inSeconds.toString().padLeft(2, '0')}'
        ':${(inMilliseconds % 60).toString().padLeft(2, '0')}';
  }
}
