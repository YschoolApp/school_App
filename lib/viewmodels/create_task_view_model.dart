import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_app/locator.dart';
import 'package:school_app/models/class_model.dart';
import 'package:school_app/models/subject_model.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/services/cloud_storage_service.dart';
// import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/task_fire_store_services.dart';
import 'package:school_app/utils/image_selector.dart';
import 'package:school_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateTaskViewModel extends BaseModel {
  final TaskFireStoreService _fireStoreService =
      locator<TaskFireStoreService>();
  final LessonsService _lessonsService = locator<LessonsService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<Subject> subjectsList;
  List<Class> classesList;

  File _selectedImage;

  File get selectedImage => _selectedImage;

  getClassAndSubject() async {
    setBusy(true);
    _selectedImage = null;
    var result = await _lessonsService.getLessons();
    if (result is List) {
      classesList = _lessonsService.classesList;
      subjectsList = _lessonsService.subjectsList;
    } else {
      await _dialogService.showDialog(
        title: 'you do not have any Class yet',
        description: result,
      );
      _navigationService.pop();
    }
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
  }

  Future selectImage(ImageSource imageSource) async {
    var tempImage = await _imageSelector.selectImage(imageSource);

    if (tempImage != null) {
      print('image');
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  submitData(GlobalKey<FormBuilderState> _formKey) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setBusy(true);

      Map<String, dynamic> allValues = _formKey.currentState.value;

      Subject selectedSubject = subjectsList.firstWhere(
          (element) => element.name == allValues['subject'], orElse: () {
        print('No matching element.');
        return null;
      });

      Class selectedClass = classesList.firstWhere(
          (element) => element.name == allValues['class'], orElse: () {
        print('No matching element.');
        return null;
      });

      // print(allValues['images']);
      // print(selectedClass.id);
      // print(selectedSubject.id);


      CloudStorageResult storageResult;

      //TODO upload all list;
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: allValues['images'][0],
        title: '${selectedClass.id}-${selectedSubject.id}',
      );

      var result;

      result = await _fireStoreService.addTask(Task(
        taskContent: allValues['taskContent'],
        subjectId: selectedSubject.id,
        classId: selectedClass.id,
        teacherId: currentUser.id,
        imageUrl: storageResult.imageUrl,
        imageFileName: storageResult.imageFileName,
      ));

      setBusy(false);

      if (result is String) {
        await _dialogService.showDialog(
          title: 'Could not not create task',
          description: result,
        );
      } else {
        await _dialogService.showDialog(
          title: 'Task successfully Added',
          description: 'Your task has been created',
        );
      }

      _navigationService.pop();
    }
  }

  // Future addTask(Task task) async {
  //   setBusy(true);

  //   CloudStorageResult storageResult;

  //   storageResult = await _cloudStorageService.uploadImage(
  //     imageToUpload: _selectedImage,
  //     title: '${task.classId}-${task.subjectId}',
  //   );

  //   var result;

  //   result = await _fireStoreService.addTask(Task(
  //     taskContent: task.taskContent,
  //     subjectId: task.subjectId,
  //     classId: task.classId,
  //     teacherId: currentUser.id,
  //     imageUrl: storageResult.imageUrl,
  //     imageFileName: storageResult.imageFileName,
  //   ));

  //   setBusy(false);

  //   if (result is String) {
  //     await _dialogService.showDialog(
  //       title: 'Could not not create task',
  //       description: result,
  //     );
  //   } else {
  //     await _dialogService.showDialog(
  //       title: 'Task successfully Added',
  //       description: 'Your task has been created',
  //     );
  //   }

  //   _navigationService.pop();
  // }

  // void setEdittingTask(Task edittingTask) {
  //   _edittingTask = edittingTask;
  // }

}
