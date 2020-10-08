import 'package:flutter/foundation.dart';

class Task {
  final String title;
  final String task;
  final String lessonId;


  Task({
    @required this.lessonId,
    @required this.title,
    this.task,

  });

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'title': title,
      'task': task,
    };
  }

  static Task fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Task(
      title: map['title'],
      task: map['task'],
      lessonId: map['lessonId'],
      
    );
  }
}
