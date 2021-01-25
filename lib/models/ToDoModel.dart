import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToDoModel with ChangeNotifier {
  UnmodifiableListView<Task> get getTasks => UnmodifiableListView(Task.tasks);

  UnmodifiableListView<Category> get getCategories =>
      UnmodifiableListView(Category.categories);

  void addItem(dynamic item) {
    if (item is Category) {
      Category.categories.insert(0, item);
      Category.currentIndex++;
    } else {
      Task.tasks.add(item);
      Task.currentIndex++;
    }
    notifyListeners();
  }

  void removeItem(index) {
    Task.tasks.removeAt(index);
    Task.currentIndex--;
    notifyListeners();
  }
}

class Task extends ToDoModel {
  static int currentIndex = 0;
  static List<Task> tasks = [];

  final int id;
  String title;

  Task(this.title) : this.id = currentIndex;
}

class Category extends ToDoModel {
  static int currentIndex = 0;
  static List<Category> categories = [Category("Add category")];

  final int id;
  String title;

  Category(this.title) : this.id = currentIndex;
}
