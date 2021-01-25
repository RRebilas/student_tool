import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToDoModel with ChangeNotifier {
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(Task.tasks);

  void addItem(dynamic item) {
    (item is Task) ? Task.add(item) : Category.add(item);
    notifyListeners();
  }

  void removeItem(index) {
    Task.remove(index);
    notifyListeners();
  }
}

class Task {
  static int currentIndex = 0;
  static List<Task> tasks = [];

  final int id;
  String title;

  Task(this.title) : this.id = currentIndex;

  static void add(Task t) {
    tasks.add(t);
    currentIndex++;
  }

  static void remove(index) {
    tasks.removeAt(index);
    currentIndex--;
  }
}

class Category {
  static int currentIndex = 0;
  static List<Category> categories = [];

  final int id;
  String title;

  Category(this.title) : this.id = currentIndex;

  static void add(Category c) {
    categories.add(c);
    currentIndex++;
  }
}
