import 'package:flutter/foundation.dart';

class Claim {
  final String userId;
  final String claimTitle;
  final String claim;


  Claim({
    @required this.userId,
    @required this.claimTitle,
    @required this.claim,

  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'claimTitle': claimTitle,
      'claim': claim,
    };
  }

  static Claim fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Claim(
      userId: map['userId'],
      claimTitle: map['claimTitle'],
      claim: map['claim'],

    );
  }
}
