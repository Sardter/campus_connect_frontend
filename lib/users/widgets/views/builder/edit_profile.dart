import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.controller});
  final EditProfileController controller;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final _segments = <CreatePageSegment>[
    EditProfileDescriptionSegment(
        controller: widget.controller.descriptionController),
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<User>(
      controller: widget.controller,
      segments: () => _segments,
      warningsController: widget.controller.warningsController,
      buttonChildren: const [
        Icon(
          Icons.share,
          color: ThemeService.onContrastColor,
        ),
        SizedBox(width: 10),
        Text(
          "Update",
          style: TextStyle(color: ThemeService.onContrastColor),
        )
      ],
      pageTitle: "Profile Edittor",
      detailPage: (secondHand) => ProfilePage(
        myProfile: true,
        id: secondHand.id,
      ),
    );
  }
}
