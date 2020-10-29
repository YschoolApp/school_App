import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/viewmodels/base_model.dart';
import '../locator.dart';

class TasksOfSubjectViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final LessonsService _lessonsService = locator<LessonsService>();
  DatabaseReference _tasksCollectionReference;
  StreamController<List<Task>> _tasksController;
  List<Task> tasksList;

  TasksOfSubjectViewModel() {
    _tasksCollectionReference =
        FirebaseDatabase.instance.reference().child('tasks');
    _tasksController = StreamController<List<Task>>.broadcast();
  }

  Stream getStream() {
    return _tasksController.stream;
  }

  startGettingData(String id) async {
    setBusy(true);
    await getTaskOfSubject(id);
    setBusy(false);
  }

  getTaskOfSubject(String subjectID) async {
    try {
      _tasksCollectionReference
          .orderByChild('classId')
          .equalTo(currentUser.classId)
          .onValue
          .listen((event) {
        tasksList = List<Task>();
        if (event.snapshot.value != null) {
          print('subject has a tasks');
          event.snapshot.value.forEach((key, values) async {
            Task task = Task.fromMap(values, key);
            print('sub id ' + task.subjectId);
            if (task.subjectId == subjectID) {
              String subjectName =
                  await _lessonsService.getSubjectName(task.subjectId);
              String className =
                  await _lessonsService.getClassName(task.classId);
              task.subjectName = subjectName;
              task.className = className;
              tasksList.add(task);
            }
            return _tasksController.add(tasksList);
          });
        }
        print('subject does not have any task');
      });

    } catch (e) {
      if (e is PlatformException) {
        print('========= e is PlatformException in getting student tasks  ========');
        print(e.message.toString());
        return e.message.toString();
      }
      print('======== e in getting student tasks =========');
      print(e.toString());
      return e.toString();
    }
  }
}
