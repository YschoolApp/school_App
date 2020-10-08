import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:school_app/models/post.dart';

import '../models/post.dart';

class TaskFireStoreService {
  final CollectionReference _tasksCollectionReference =
  FirebaseFirestore.instance.collection('tasks');

  final StreamController<List<Task>> _tasksController =
  StreamController<List<Task>>.broadcast();

  StreamController<List<Task>> get tasksController => _tasksController;

  // #6: Create a list that will keep the paged results
  List<List<Task>> _allPagedResults = List<List<Task>>();

  static const int TasksLimit = 2;

  DocumentSnapshot _lastDocument;
  bool _hasMoreTasks = true;

  bool get hasMoreTasks => _hasMoreTasks;

  Stream listenToTasksRealTime() {
    // Register the handler for when the tasks data( changes
    _requestTasks();
    return _tasksController.stream;
  }

  void requestMoreData() => _requestTasks();

  // #1: Move the request tasks into it's own function
  void _requestTasks() {
    // #2: split the query from the actual subscription

    var pageTasksQuery = _tasksCollectionReference
        .orderBy('title')
    // #3: Limit the amount of results
        .limit(TasksLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pageTasksQuery = pageTasksQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMoreTasks) {
      print('!_hasMoreTasks');
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pageTasksQuery.snapshots().listen((tasksSnapshot) {
      if (tasksSnapshot.docs.isNotEmpty) {
        var tasks = tasksSnapshot.docs
            .map((snapshot) => Task.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the tasks for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = tasks;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(tasks);
        }

        // #11: Concatenate the full list to be shown
        var allTasks = _allPagedResults.fold<List<Task>>(List<Task>(),
                (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _tasksController.add(allTasks);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = tasksSnapshot.docs.last;
        }

        print('tasks length is ${tasks.length}');

        // #14: Determine if there's more posts to request
        _hasMoreTasks = tasks.length == TasksLimit;
      } else {
        _hasMoreTasks = false;
      }
    });

    print('end request');
  }

  Future addTask(Task task) async {
    try {
      await _tasksCollectionReference.add(task.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getTasksOnceOff() async {
    try {
      var taskDocumentSnapshot =
      await _tasksCollectionReference.limit(TasksLimit).get();
      if (taskDocumentSnapshot.docs.isNotEmpty) {
        return taskDocumentSnapshot.docs
            .map((snapshot) => Task.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future deleteTask(String documentId) async {
    await _tasksCollectionReference.doc(documentId).delete();
  }

  Future updateTask(Task task) async {
    try {
      //await _tasksCollectionReference.doc(task.documentId).update(task.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

}