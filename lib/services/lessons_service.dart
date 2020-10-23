import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:school_app/models/class_model.dart';
import 'package:school_app/models/lesson_model.dart';
import 'package:school_app/models/subject_model.dart';

class LessonsService {
  DatabaseReference _lessonCollectionReference;
  DatabaseReference _subjectCollectionReference;
  DatabaseReference _classCollectionReference;

  List<Lesson> lessonsList;
  List<Subject> subjectsList;
  List<Class> classesList;

  LessonsService() {
    lessonsList = [];
    classesList = [];
    subjectsList = [];
    _lessonCollectionReference =
        FirebaseDatabase.instance.reference().child('lesson');
    _subjectCollectionReference =
        FirebaseDatabase.instance.reference().child('Subject');
    _classCollectionReference =
        FirebaseDatabase.instance.reference().child('Class');
  }

  Future getLessons() async {
    print("start getLessons");
    lessonsList.clear();
    subjectsList.clear();
    classesList.clear();
    try {
      await _lessonCollectionReference
          .orderByChild('teacher_id')
          .equalTo(FirebaseAuth.instance.currentUser.uid)
          .once()
          .then((snapshot) {
        snapshot.value.forEach((key, values) async {
          Lesson lesson = Lesson.fromJson(values);
          print('sub id ' + lesson.subjectId);
          String subjectName = await getSubjectName(lesson.subjectId);
          String className = await getClassName(lesson.classId);
          lesson.subjectName = subjectName;
          lesson.className = className;
          lessonsList.add(lesson);
        });
      });
      return lessonsList;
      print("end getLessons");
    } catch (e) {
      if (e is PlatformException) {
        print('========= e is PlatformException in getting Lessons  ========');
        print(e.message.toString());
        return e.message.toString();
      }
      print('======== e in getting Lessons=========');
      print(e.toString());
      return e.toString();
    }
  }

  Future getSubjectName(String subjId) async {
    try {
      String subjectName;
      var result = await _subjectCollectionReference
          .orderByChild('id')
          .equalTo(subjId)
          .once();

      print(' ---- getSubjects');

      result.value.forEach((key, value) {
        Subject subject = Subject.fromMap(value, key);
        subjectName = subject.name;
        subjectsList.add(subject);
      });
      print(subjectName);
      return subjectName;
    } catch (e) {
      if (e is PlatformException) {
        print(
            '========= e is PlatformException in getting SubjectName  ========');
        print(e.message.toString());
        return e.message;
      }
      print('======== e in getting SubjectName=========');
      print(e.toString());
      return e.toString();
    }
  }

  Future getClassName(String classId) async {
    try {
      String className;
      var result = await _classCollectionReference
          .orderByChild('id')
          .equalTo(classId)
          .once();

      print(' ---- getClassName');

      result.value.forEach((key, value) {
        Class newClass = Class.fromMap(value, key);
        className = newClass.name;
        classesList.add(newClass);
      });
      print(className);
      return className;
    } catch (e) {
      if (e is PlatformException) {
        print(
            '========= e is PlatformException in getting ClassName  ========');
        print(e.message.toString());
        return e.message;
      }
      print('======== e in getting ClassName=========');
      print(e.toString());
      return e.toString();
    }
  }
}
