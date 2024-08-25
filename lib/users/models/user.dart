import 'package:campus_connect_frontend/users/models/models.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_ui;

class User extends ModelWithMedia {
  final String email;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final ImageData? profilePhoto;
  final int secondHandSales;
  final UserAllowedActions? allowedActions;
  final int donations;

  String get displayName {
    if (firstName == null && lastName == null) {
      return email;
    } else if (lastName == null && firstName != null) {
      return firstName!;
    } else if (firstName == null && lastName != null) {
      return lastName!;
    }
    return "$firstName $lastName";
  }

  chat_ui.User get chatUIUser => chat_ui.User(
      id: id.toString(),
      firstName: firstName,
      lastName: lastName,
      imageUrl: profilePhoto?.url);

  const User(
      {required super.id,
      required this.email,
      this.bio,
      this.firstName,
      this.lastName,
      this.allowedActions,
      this.profilePhoto,
      this.secondHandSales = 0,
      this.donations = 0});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'bio': bio,
      'first_name': firstName,
      'last_name': lastName,
      'media': [
        if (profilePhoto == null) NetworkEmptyMediaData() else profilePhoto
      ].map((e) => e!.toJson()).toList(),
    };
  }
  
  @override
  List<MediaData?> get media => [
    profilePhoto
  ];
}
