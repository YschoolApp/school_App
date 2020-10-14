
class Task {
  final String teacherId;
  final String taskId;
  final String taskContent;
  final String lessonId;
  final String uploadTime;

  Task({
    this.lessonId,
    this.teacherId,
    this.taskContent,
    this.taskId,
    this.uploadTime
  });

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'teacherId': teacherId,
      'task': taskContent,
      'uploadTime':DateTime.now().toString(),
    };
  }

  static Task fromMap(Map map, String documentId) {
    if (map == null) return null;
    return Task(
      taskId: documentId,
      teacherId: map['teacherId'],
      taskContent: map['task'],
      lessonId: map['lessonId'],
      uploadTime: map['uploadTime'],
    );
  }
}
