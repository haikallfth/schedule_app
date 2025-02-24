class Task {
  final String name;
  final String priority;
  final int duration;
  final String deadline;

  Task(this.name, this.priority, this.duration, this.deadline);

  @override
  String toString() {
    return 'Task{name: $name, priority: $priority, duration: $duration, deadline: $deadline}';
  }
}