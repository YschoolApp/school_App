import 'package:intl/intl.dart';

class Task {
  final String teacherId;
  final String taskId;
  final String taskContent;
  final String subjectId;
  final String classId;
  final String uploadTime;
  final String imageUrl;
  final String imageFileName;
  final String taskTitle;
  String subjectName;
  String className;

  Task(
      {this.subjectId,
      this.imageUrl,
      this.imageFileName,
      this.teacherId,
      this.taskContent,
      this.taskId,
      this.taskTitle,
      this.classId,
      this.subjectName,
      this.className,
      this.uploadTime});

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'classId': classId,
      'teacherId': teacherId,
      'task': taskContent,
      'imageFileName': imageFileName,
      'taskTitle': taskTitle,
      'imageUrl': imageUrl,
      'uploadTime': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    };
  }

  static Task fromMap(Map map, String documentId) {
    if (map == null) return null;
    return Task(
      taskId: documentId,
      teacherId: map['teacherId'],
      taskContent: map['task'],
      subjectId: map['subjectId'],
      classId: map['classId'],
      taskTitle: map['taskTitle'],
      imageUrl: map['imageUrl'],
      imageFileName: map['imageFileName'],
      uploadTime: map['uploadTime'],
    );
  }
}
