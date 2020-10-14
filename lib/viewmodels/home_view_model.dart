import 'dart:async';
import 'package:school_app/locator.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/task_fire_store_services.dart';
import 'package:school_app/viewmodels/base_model.dart';

import '../routers/route_names.dart';
import 'package:firebase_database/firebase_database.dart';
class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TaskFireStoreService _firestoreService =
      locator<TaskFireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  Query query;

  getQuery() {
    query = _firestoreService.query;
  }

  // Stream<List<Task>> stream;

//   void listenToTasks() {
//
//     setBusy(true);
//
//     _firestoreService.listenToTasksRealTime();
//
//     stream = _firestoreService.tasksController.stream;
//
//     setBusy(false);
// //    });
//   }

  Future deleteTask(Task taskToDelete) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the task?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteTask(taskToDelete.taskId);
      // Delete the image after the task is deleted
      // await _cloudStorageService.deleteImage(taskToDelete.imageFileName);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateTaskViewRoute);
  }

  void editTask(int index) {
//    _navigationService.navigateTo(CreatePostViewRoute,
//        arguments: _posts[index]);
  }

  // void requestMoreData() => _firestoreService.requestMoreData();

  Future<void> refresh() {
    return Future.value();
  }
}
