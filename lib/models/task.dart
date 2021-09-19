class Task {
  final String name;
  final dateTime = new DateTime.now();
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() => isDone = !isDone;
}
