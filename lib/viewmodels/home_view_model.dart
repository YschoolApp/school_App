import 'dart:async';
import 'package:school_app/locator.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/post_fire_store_services.dart';
import 'package:school_app/viewmodels/base_model.dart';

import '../routers/route_names.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PostFireStoreService _firestoreService =
      locator<PostFireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();


  Stream<List<Post>> stream;

  void listenToPosts() {

    setBusy(true);

    _firestoreService.listenToPostsRealTime();

    stream = _firestoreService.postsController.stream;

    setBusy(false);
//    });
  }

  Future deletePost(Post postToDelete) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deletePost(postToDelete.documentId);
      // Delete the image after the post is deleted
      await _cloudStorageService.deleteImage(postToDelete.imageFileName);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostViewRoute);
  }

  void editPost(int index) {
//    _navigationService.navigateTo(CreatePostViewRoute,
//        arguments: _posts[index]);
  }

  void requestMoreData() => _firestoreService.requestMoreData();

  Future<void> refresh() {
    return Future.value();
  }
}


