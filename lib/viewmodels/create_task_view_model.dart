import 'dart:io';
import 'package:school_app/locator.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/task_fire_store_services.dart';
import 'package:school_app/utils/image_selector.dart';
import 'package:school_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateTaskViewModel extends BaseModel {
  final TaskFireStoreService _fireStoreService =
      locator<TaskFireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;

  File get selectedImage => _selectedImage;

  Task _edittingTask;

  bool get _editting => _edittingTask != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future addTask({@required String task}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    var result;

    if (!_editting) {
      result = await _fireStoreService.addTask(Task(
        task: task,
        lessonId: "",
        teacherId: currentUser.id,
        // imageUrl: storageResult.imageUrl,
        // imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _fireStoreService.updateTask(Task(
        task: task,
        lessonId: "",
        teacherId: currentUser.id,
        //documentId: _edittingTask.documentId,
        //imageUrl: _edittingPost.imageUrl,
        //imageFileName: _edittingPost.imageFileName,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create task',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your task has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingTask(Task edittingTask) {
    _edittingTask = edittingTask;
  }
}
