import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  static Database _database;
  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'todo.db');

    Database databse =
        await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return databse;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NULL, image TEXT NULL, due_date DATETIME NOT NULL, tag_id INTEGER NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL)",
    );

    await db.execute(
      "CREATE TABLE tag(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, color TEXT, is_selected INTEGER)",
    );

    await db.execute(
        "INSERT INTO tag(name, color, is_selected) VALUES('travel', '${Colors.red.value}', 0),('personal', '${Colors.green.value}', 0),('life', '${Colors.purple.value}', 0),('work', '${Colors.orange.value}', 0),('untagged', '${Colors.blueAccent.value}', 1)");
  }

  Future<List<Map<String, dynamic>>> fetchAllTasks() async {
    try {
      Database client = await db;
      List<Map<String, dynamic>> result =
          await client.rawQuery("SELECT * FROM task");
      // await client.rawQuery("SELECT title, description, image, due_date, tag_id FROM task");
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<int> saveTask(Map<String, dynamic> task) async {
    try {
      Database client = await db;
      int res = await client.insert("task", task);
      return res;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllTags() async {
    try {
      Database client = await db;
      List<Map<String, dynamic>> result =
          await client.rawQuery("SELECT * FROM tag");
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<int> tagSelection(String name) async {
    Database client = await db;
    int res = await client.rawUpdate("""
      UPDATE tag SET is_selected = 1 WHERE name = '$name'""");
    res = await client.rawUpdate("""
      UPDATE tag SET is_selected = 0 WHERE NOT name = '$name'""");
    return res;
  }

  Future<int> saveTag(Map<String, dynamic> tag) async {
    try {
      Database client = await db;
      int res = await client.insert("tag", tag);
      await client.rawQuery(
          "UPDATE tag SET is_selected = 0 WHERE NOT name = '${tag['name']}'");
      return res;
    } catch (error) {
      throw error;
    }
  }
}
