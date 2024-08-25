import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EditProfileDescriptionData {
  final String email;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final ImageData? profilePhoto;

  const EditProfileDescriptionData(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.profilePhoto});
}

class EditProfileDescriptionController
    extends BuilderSegmentController<EditProfileDescriptionData> {
  final BuilderWarningsController warningsController;

  final String? initialEmail;
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialBio;
  final ImageData? initialProfilePhoto;

  EditProfileDescriptionController({
    required this.warningsController,
    this.initialBio,
    this.initialEmail,
    this.initialFirstName,
    this.initialLastName,
    this.initialProfilePhoto,
  });

  late final emailController = TextEditingController(text: initialEmail);
  late final firstNameController =
      TextEditingController(text: initialFirstName);
  late final lastNameController = TextEditingController(text: initialLastName);
  late final bioController = TextEditingController(text: initialBio);
  late final photoController = ValueNotifier<ImageData?>(initialProfilePhoto);

  @override
  EditProfileDescriptionData? get data => !isValid
      ? null
      : EditProfileDescriptionData(
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          bio: bioController.text,
          profilePhoto: photoController.value);

  @override
  List<String> get errorMesseges => [
        if (!EmailValidator.validate(emailController.text))
          "Email must be valid",
        if (firstNameController.text.isEmpty) "First name cannot be empty",
        if (lastNameController.text.isEmpty) "Last name cannot be empty",
      ];
}
