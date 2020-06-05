import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

int currentIndex = 0;
List<Task> _tasks = [];

class ToDoModel with ChangeNotifier {
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void add(Task task) {
    _tasks.add(task);
    currentIndex++;
    notifyListeners();
  }

  void remove(int index) {
    _tasks.removeAt(index);
    currentIndex--;
    notifyListeners();
  }
}

class Task {
  final int id;
  final String title;

  Task(this.title) : this.id = currentIndex;

  @override
  // TODO: implement hashCode
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Task && other.id == id;
}
