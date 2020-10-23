import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:school_app/models/user_model.dart';

class UserFireStoreService {

  // final CollectionReference _usersCollectionReference =
  // FirebaseFirestore.instance.collection('users');

  FirebaseDatabase database;
  DatabaseReference _usersCollectionReference;

  UserFireStoreService() {
    
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _usersCollectionReference =
        FirebaseDatabase.instance.reference().child('users');
    _usersCollectionReference.keepSynced(true);

  }

  Future createUser(MyUser user) async {
    try {
      await _usersCollectionReference.child(user.id).set(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {

      var userData = await _usersCollectionReference.child(uid).once();

      print('===== get user from fireStore');

      print(userData.value.toString());

      return MyUser.fromJson(userData.value);

    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        print('========= e is PlatformException ========');
        print(e.message.toString());
        return e.message;
      }
      print('======== e =========');
      print(e.toString());
      return e.toString();
    }
  }

  // Future createUser(MyUser user) async {
  //   try {
  //     await _usersCollectionReference.doc(user.id).set(user.toJson());
  //   } catch (e) {
  //     // TODO: Find or create a way to repeat error handling without so much repeated code
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //
  //     return e.toString();
  //   }
  // }
  //
  // Future getUser(String uid) async {
  //   try {
  //     var userData = await _usersCollectionReference.doc(uid).get();
  //     return MyUser.fromJson(userData.data());
  //   } catch (e) {
  //     // TODO: Find or create a way to repeat error handling without so much repeated code
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //     return e.toString();
  //   }
  // }
}
