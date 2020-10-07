import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/models/user_model.dart';
import '../locator.dart';
import 'firestore_service.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required MyUser passedUser,
    @required String password,

  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: passedUser.userEmail,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = MyUser(
        id: authResult.user.uid,
        userEmail: passedUser.userEmail,
        userFullName: passedUser.userFullName,
        userAddress: passedUser.userAddress,
        userPhone: passedUser.userPhone,
        userRole: passedUser.userRole,
      );

      await _fireStoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user =  _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }
}
