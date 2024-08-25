import 'package:flutter/material.dart';

class AllowedActions {
  final bool canUpdate;
  final bool canDelete;
  final bool canHide;
  final bool canReport;

  const AllowedActions(
      {required this.canUpdate,
      required this.canDelete,
      required this.canHide,
      required this.canReport});

  factory AllowedActions.fromJson(Map json) {
    return AllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canHide: json['can_hide'] ?? false,
        canReport: json['can_report'] ?? false);
  }
}

class ActionData {
  final IconData icon;
  final String title;
  final Future<void> Function() onTap;

  const ActionData(
      {required this.icon, required this.title, required this.onTap});
}
