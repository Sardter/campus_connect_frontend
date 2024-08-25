import 'package:campus_connect_frontend/users/widgets/views/views.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class EditProfileDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const EditProfileDescriptionSegment({super.key, required this.controller});
  final EditProfileDescriptionController controller;

  @override
  State<EditProfileDescriptionSegment> createState() =>
      _EditProfileDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Details";
}

class _EditProfileDescriptionSegmentState
    extends State<EditProfileDescriptionSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SelectedLogo(
              notifier: widget.controller.photoController,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, color: ThemeService.unusedColor),
                  SizedBox(width: 10),
                  Text(
                    "Photo",
                    style: TextStyle(color: ThemeService.unusedColor),
                  )
                ],
              )),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.emailController,
              hint: "Email"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.firstNameController,
              hint: "First Name"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.lastNameController,
              hint: "Last Name"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.bioController,
              hint: "Bio"),
        ],
      ),
    );
  }
}
