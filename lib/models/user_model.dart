class MyUser {
  final String id;
  final String userFullName;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String userRole;

  MyUser(
      {this.id,
      this.userFullName,
      this.userEmail,
      this.userRole,
      this.userAddress,
      this.userPhone});

  MyUser.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        userFullName = data['userFullName'],
        userEmail = data['userEmail'],
        userRole = data['userRole'],
        userAddress = data['userAddress'],
        userPhone = data['userPhone'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userFullName': userFullName,
      'userPhone':userPhone,
      'userEmail': userEmail,
      'userRole': userRole,
    };
  }
}
