import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:school_app/models/claim.dart';
import '../models/claim.dart';

class ClaimFireStoreService {

  FirebaseDatabase database;
  DatabaseReference _claimsCollectionReference;

  ClaimFireStoreService() {
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    // database.setPersistenceCacheSizeBytes(10000000);
    _claimsCollectionReference =
        FirebaseDatabase.instance.reference().child('claims');
  }

  final StreamController<List<Claim>> _claimsController =
  StreamController<List<Claim>>.broadcast();

  StreamController<List<Claim>> get claimsController => _claimsController;

  // #6: Create a list that will keep the paged results
  List<List<Claim>> _allPagedResults = List<List<Claim>>();

  static const int ClaimsLimit = 2;

  DocumentSnapshot _lastDocument;
  bool _hasMoreClaims = true;

  bool get hasMoreClaims => _hasMoreClaims;

  Stream listenToClaimsRealTime() {
    // Register the handler for when the claims data( changes
    _requestClaims();
    return _claimsController.stream;
  }

  void requestMoreData() => _requestClaims();

  // #1: Move the request claims into it's own function

  void _requestClaims() {
    // #2: split the query from the actual subscription

    var pageClaimsQuery = _claimsCollectionReference
        .orderByChild('title')
    // #3: Limit the amount of results
        .limitToFirst(ClaimsLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pageClaimsQuery = pageClaimsQuery.startAt(_lastDocument);
    }

    if (!_hasMoreClaims) {
      print('!_hasMoreClaims');
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pageClaimsQuery.onValue.listen((claimsSnapshot) {
      if (claimsSnapshot.snapshot.value.isNotEmpty) {
        var claims = claimsSnapshot.snapshot.value
            .map((snapshot) => Claim.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.claim != null)
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the tasks for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = claims;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(claims);
        }

        // #11: Concatenate the full list to be shown
        var allClaims = _allPagedResults.fold<List<Claim>>(List<Claim>(),
                (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _claimsController.add(allClaims);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = claimsSnapshot.snapshot.value.last;
        }

        print('claims length is ${claims.length}');

        // #14: Determine if there's more posts to request
        _hasMoreClaims = claims.length == ClaimsLimit;
      } else {
        _hasMoreClaims = false;
      }
    });

    print('end request');
  }

  Future addClaim(Claim claim) async {
    try {
      await _claimsCollectionReference.push().set(claim.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // Future getTasksOnceOff() async {
  //   try {
  //     var taskDocumentSnapshot =
  //     await _tasksCollectionReference.limitToFirst(TasksLimit).once();
  //     if (taskDocumentSnapshot.value!=null) {
  //       return taskDocumentSnapshot.value
  //           .map((snapshot) => Task.fromMap(snapshot.data(), snapshot.id))
  //           .where((mappedItem) => mappedItem.task != null)
  //           .toList();
  //     }
  //   } catch (e) {
  //     // TODO: Find or create a way to repeat error handling without so much repeated code
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //
  //     return e.toString();
  //   }
  // }

  Future deleteClaim(String documentId) async {
    await _claimsCollectionReference.child(documentId).remove();
  }

  Future updateClaim(Claim claim) async {
    try {
      // await _tasksCollectionReference.child(task.documentId).update(task.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}

