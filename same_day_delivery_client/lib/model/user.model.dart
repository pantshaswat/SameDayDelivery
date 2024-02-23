class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  String userAddress;
  String userDate;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userAddress,
    required this.userDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'user_email': userEmail,
      'user_password': userPassword,
      'user_phone': userPhone,
      'user_address': userAddress,
      'user_date': userDate,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      userPassword: json['user_password'],
      userPhone: json['user_phone'],
      userAddress: json['user_address'],
      userDate: json['user_date'],
    );
  }
}
