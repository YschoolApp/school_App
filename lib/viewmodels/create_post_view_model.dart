import 'dart:io';
import 'package:school_app/locator.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/post_fire_store_services.dart';
import 'package:school_app/utils/image_selector.dart';
import 'package:school_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends BaseModel {

  final PostFireStoreService _fireStoreService = locator<PostFireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Post _edittingPost;

  bool get _editting => _edittingPost != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }

    var result;

    if (!_editting) {
      result = await _fireStoreService.addPost(Post(
        title: title,
        userId: currentUser.id,
        imageUrl: storageResult.imageUrl,
        imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _fireStoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
