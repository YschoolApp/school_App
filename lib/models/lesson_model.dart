class Lesson {
  String subjectId;
  String lessonNo;
  String teacherId;
  String classId;
  String lessonDay;
  String id;
  String docId;
  String _subjectName;
  String _className;


  String get subjectName => _subjectName;

  set subjectName(String value) {
    _subjectName = value;
  }


  String get className => _className;

  set className(String value) {
    _className = value;
  }

  Lesson(
      {this.subjectId,
      this.lessonNo,
      this.teacherId,
      this.classId,
      this.lessonDay,
      this.id,
      this.docId});

  Lesson.fromJson(Map data, {String docID})
      : id = data['id'],
        subjectId = data['subject_id'],
        lessonNo = data['lesson_no'],
        teacherId = data['teacher_id'],
        classId = data['class_id'],
        lessonDay = data['lesson_day'],
        docId = docID;

}
