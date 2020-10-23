class Task {
  final String teacherId;
  final String taskId;
  final String taskContent;
  final String subjectId;
  final String classId;
  final String uploadTime;
  final String imageUrl;
  final String imageFileName;

  Task(
      {this.subjectId,
      this.imageUrl,
      this.imageFileName,
      this.teacherId,
      this.taskContent,
      this.taskId,
      this.classId,
      this.uploadTime});

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'classId': classId,
      'teacherId': teacherId,
      'task': taskContent,
      'imageFileName':imageFileName,
      'imageUrl':imageUrl,
      'uploadTime': DateTime.now().toString(),
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
      imageUrl: map['imageUrl'],
      imageFileName: map['imageFileName'],
      uploadTime: map['uploadTime'],
    );
  }
}
