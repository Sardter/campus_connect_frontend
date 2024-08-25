import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class UserFactory extends ModelFactory<User> {
  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        secondHandSales: json['second_hand_sales'] ?? 0,
        donations: json['donations'] ?? 0,
        profilePhoto:
            json['media'] == null || json['media'].isEmpty ? null : NetworkImageData(url: json['media'][0]),
        allowedActions: json['request_data']?['allowed_actions'] == null
            ? null
            : UserAllowedActions.fromJson(json['request_data']['allowed_actions']));
  }
}
