enum Headers {
  history(name: 'History'),
  stopwatch(name: 'Stopwatch'),
  profile(name: 'Profile');

  final String name;
  const Headers({required this.name});
}
