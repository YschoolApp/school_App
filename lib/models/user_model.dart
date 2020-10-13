class MyUser {
  final String id;
  final String userFullName;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String userRole;
  final bool isActivate;

  MyUser({this.id,
    this.userFullName,
    this.userEmail,
    this.userRole,
    this.userAddress,
    this.isActivate = false,
    this.userPhone});

  //when using real time it does not return Map<String, dynamic>
  //so we have to pass any Map
  MyUser.fromJson(Map data)
      : id = data['id'],
        userFullName = data['userFullName'],
        userEmail = data['userEmail'],
        userRole = data['userRole'],
        userAddress = data['userAddress'],
        isActivate = data['isActivate'],
        userPhone = data['userPhone'];

  // MyUser.fromJson(Map<String, dynamic> data)
  //     : id = data['id'],
  //       userFullName = data['userFullName'],
  //       userEmail = data['userEmail'],
  //       userRole = data['userRole'],
  //       userAddress = data['userAddress'],
  //       isActivate = data['isActivate'],
  //       userPhone = data['userPhone'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userFullName': userFullName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'userRole': userRole,
      'isActivate': isActivate,
    };
  }
}
