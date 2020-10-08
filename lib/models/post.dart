import 'package:flutter/foundation.dart';

class Task {
  final String teacherId;
  final String task;
  final String lessonId;


  Task({
    @required this.lessonId,
    @required this.teacherId,
    this.task,

  });

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'teacherId': teacherId,
      'task': task,
    };
  }

  static Task fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Task(
      teacherId: map['teacherId'],
      task: map['task'],
      lessonId: map['lessonId'],
      
    );
  }
}
