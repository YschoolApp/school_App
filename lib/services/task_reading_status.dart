import 'dart:convert';

import 'package:hive/hive.dart';

class TaskReadingStatus{
  Box<dynamic> _tasksBox;


  startFetchStatus(int taskId) async {
    _tasksBox = await Hive.openBox('videoBox');
    if (_tasksBox.get(taskId) == null) {
      print("task box is null");
      return;
    }

    var task = Map<String, dynamic>.from(jsonDecode(_tasksBox.get(taskId)));

    if (task != null) {
      print("task box has a value");

    }
  }

  saveTaskInfoToHive(String taskId,bool status) async {
    await _tasksBox.put(taskId, status);
  }

  // bool checkStatus(String taskId) {
  //   if (taskId != null) {
  //     return true;
  //   } else
  //     return false;
  // }

  closeBox() {
    _tasksBox.close();
  }


}