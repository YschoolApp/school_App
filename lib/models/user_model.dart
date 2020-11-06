class MyUser {
   String id;
   String userFullName;
   String userEmail;
   String userPhone;
   String userAddress;
   String userRole;
   bool isActivate;
   String classId;

  MyUser({this.id,
    this.userFullName,
    this.userEmail,
    this.userRole,
    this.userAddress,
    this.classId,
    this.isActivate = false,
    this.userPhone});

  //when using real time it does not return Map<String, dynamic>
  //so we have to pass any Map
  MyUser.fromJson(Map data)
      : id = data['id'],
        userFullName = data['userFullName'],
        userEmail = data['userEmail'],
        userRole = data['userRole'],
        classId = data['classId'],
        userAddress = data['userAddress'],
        isActivate = data['isActivate'],
        userPhone = data['userPhone'];

   factory MyUser.fromMap(Map map,String docID) {
     return new MyUser(
       userFullName: map['userFullName'] as String,
       userEmail: map['userEmail'] as String,
       userRole: map['userRole'] as String,
       classId: map['classId'] as String,
       userAddress: map['userAddress'] as String,
       isActivate: map['isActivate'] as bool,
       userPhone: map['userPhone'] as String,
       id: docID,
     );
   }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userFullName': userFullName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'userRole': userRole,
      'isActivate': isActivate,
      'classId':classId
    };
  }
}
