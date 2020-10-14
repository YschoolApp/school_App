import 'dart:io';
import 'package:school_app/locator.dart';
import 'package:school_app/models/claim.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/claim_fire_store_services.dart';
import 'package:school_app/utils/image_selector.dart';
import 'package:school_app/viewmodels/base_model.dart';

class CreateClaimViewModel extends BaseModel {
  final ClaimFireStoreService _fireStoreService =
  locator<ClaimFireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  // final CloudStorageService _cloudStorageService =
  // locator<CloudStorageService>();

  File _selectedImage;

  File get selectedImage => _selectedImage;

  Claim _edittingClaim;

  bool get _editting => _edittingClaim != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future addClaim( String title,  String claim) async {
    setBusy(true);

    // CloudStorageResult storageResult;

    var result;

    if (!_editting) {
      result = await _fireStoreService.addClaim(Claim(
        userId: currentUser.id,
        claimTitle: "",
        claim: "",
        // imageUrl: storageResult.imageUrl,
        // imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _fireStoreService.updateClaim(Claim(
        userId: currentUser.id,
        claimTitle: "",
        claim: "",

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

  void setEdittingClaim(Claim edittingClaim) {
    _edittingClaim = edittingClaim;
  }
}
