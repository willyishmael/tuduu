class Task {
  String id;
  String description;
  bool checked;
  List<Subtask> subtasks;

  Task({
    required this.id,
    required this.description,
    this.checked = false,
    this.subtasks = const [],
  });

  void check() {
    checked = !checked;
  }

  void updateDescription(String description) {
    this.description = description;
  }

  void addSubtask(Subtask subtask) {
    subtasks.add(subtask);
  }

  void removeSubtaskAt(int index) {
    if (index >= 0 && index < subtasks.length) {
      subtasks.removeAt(index);
    }
  }
}

class Subtask {
  String description;
  bool checked;

  Subtask({
    required this.description,
    this.checked = false,
  });

  void check() {
    checked = !checked;
  }
}
