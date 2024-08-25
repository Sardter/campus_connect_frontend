import 'package:campus_connect_frontend/utilities/models/allowed_actions.dart';

class UserAllowedActions extends AllowedActions {
  final bool canBlock;
  const UserAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required super.canHide,
      required this.canBlock,
      required super.canReport});

  factory UserAllowedActions.fromJson(Map<String, dynamic> json) {
    return UserAllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canHide: json['can_hide'] ?? false,
        canBlock: json['can_block'] ?? false,
        canReport: json['can_report'] ?? false);
  }
}
