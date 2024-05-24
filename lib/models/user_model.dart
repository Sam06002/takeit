// ignore_for_file: file_names

class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userImg;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final bool isShop;
  final bool isActive;
  final dynamic createdOn;
  final String city;
  final String aov;
  final String objId;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isShop,
    required this.isActive,
    required this.createdOn,
    required this.city,
    required this.aov,
    required this.objId,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userAddress': userAddress,
      'street': street,
      'isShop': isShop,
      'isActive': isActive,
      'createdOn': createdOn,
      'city': city,
      'aov': aov,
      'MobjectId': objId
    };
  }

  // Create a UserModel instance from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
        uId: json['uId'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        userImg: json['userImg'],
        userDeviceToken: json['userDeviceToken'],
        country: json['country'],
        userAddress: json['userAddress'],
        street: json['street'],
        isShop: json['isShop'],
        isActive: json['isActive'],
        createdOn: json['createdOn'].toString(),
        city: json['city'],
        aov: json['aov'],
        objId: json['mobjectId']);
  }
}
