import 'package:flutter/foundation.dart';

import '../utils/database_exception.dart';
import '../utils/database_helper.dart';
import '../models/todo.dart';
import '../models/tag.dart';

class TodoProvider extends ChangeNotifier {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Todo> _allTodos = [];
  List<Tag> _allTags = [];

  List<Todo> get todos {
    return [..._allTodos.reversed];
  }

  List<Tag> get tags {
    print(_allTags);
    return [..._allTags];
  }

  List<Todo> get upComingTodos {
    DateTime currentDate = DateTime.now();
    List<Todo> upTodos = _allTodos.where((Todo todo) {
      return !todo.dueDate.isBefore(currentDate);
    }).toList();
    upTodos.sort((todo, todo1) {
      return todo.dueDate.compareTo(todo1.dueDate);
    });
    // print(_allTodos);
    return [...upTodos];
  }

  Future<void> fetchAndSetTodos() async {
    try {
      _allTodos = (await _dbHelper.fetchAllTasks())
          .map((Map<String, dynamic> json) => Todo.fromMap(json))
          .toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> saveTodo(Todo todo) async {
    try {
      int lastAddedId = await _dbHelper.saveTask(todo.toMap());
      if (lastAddedId < 0) {
        throw DatabaseException("Todo Insertion Failed!");
      }
      await fetchAndSetTodos();
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<void> fetchAndSetTags() async {
    try {
      _allTags = (await _dbHelper.fetchAllTags())
          .map((Map<String, dynamic> json) => Tag.fromMap(json))
          .toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> tagSelection(String name) async {
    try {
      int id = await _dbHelper.tagSelection(name);
      if (id < 0) {
        throw DatabaseException("Tag Selection Failed!");
      }
      await fetchAndSetTags();
    } catch (error) {
      throw error;
    }
  }

  Future<void> saveTag(Tag tag) async {
    int indexTag = _allTags.indexWhere((tg) => tg.name == tag.name);
    if (indexTag == -1) {
      try {
        int lastAddedId = await _dbHelper.saveTag(tag.toMap());
        if (lastAddedId < 0) {
          throw DatabaseException("Tag Insertion Failed!");
        }
        // await tagSelection(tag.name);
        await fetchAndSetTags();
      } catch (error) {
        print("Error: $error");
        throw error;
      }
    } else {
      return;
    }
  }

  Tag get selectedTag {
    var tempTag =
        _allTags.firstWhere((tag) => tag.isSelected, orElse: () => null);
    tempTag != null
        ? print("selectedTag ${(tempTag as Tag).name}")
        : print("none");
    // if (tempTag == null) {
    //   return _allTags.firstWhere((tag) => tag.name.toLowerCase() == "untagged",
    //       orElse: () => null);
    // }
    return tempTag;
  }
}
