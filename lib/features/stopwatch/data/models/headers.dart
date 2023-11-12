enum Headers {
  stopwatch(name: 'Stopwatch'),
  history(name: 'History');

  final String name;
  const Headers({required this.name});
}
