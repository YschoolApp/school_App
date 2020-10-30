import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:school_app/viewmodels/base_model.dart';

class TasksViewModel extends BaseModel {

  bool _isRead = true;

  bool get isRead => _isRead;
  
  setTaskAsRead({String subjectName, String taskId}) async {
    await Hive.box(subjectName).put(taskId, true);
    _isRead = true;
  }

  setTaskAsUnRead({String subjectName, String taskId}) async {
    setBusy(true);
    await Hive.box(subjectName).put(taskId, false);
    _isRead = false;
    setBusy(false);
  }


}
