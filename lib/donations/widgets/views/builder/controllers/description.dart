import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateDonationDescriptionData {
  final String title;
  final String description;
  final double currentValue;
  final double targetValue;
  final Subject? subject;

  const CreateDonationDescriptionData(
      {required this.title,
      required this.description,
      required this.subject,
      required this.currentValue,
      required this.targetValue});
}

class CreateDonationDescriptionController
    extends BuilderSegmentController<CreateDonationDescriptionData> {
  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialDescription;
  final double? initialCurrentValue;
  final double? initialTargetValue;
  final Subject? initialSubject;

  CreateDonationDescriptionController(
      {required this.warningsController,
      this.initialTitle,
      this.initialDescription,
      this.initialSubject,
      this.initialCurrentValue,
      this.initialTargetValue,});

  late final titleController = TextEditingController(text: initialTitle);
  late final descriptionController =
      TextEditingController(text: initialDescription);
  late final currentValueController = ValueNotifier<double?>(initialCurrentValue);
  late final targetValueController = ValueNotifier<double?>(initialTargetValue);
  late final subjectController = TextEditingController(text: initialSubject?.id);


  @override
  CreateDonationDescriptionData? get data => !isValid
      ? null
      : CreateDonationDescriptionData(
          title: titleController.text,
          currentValue: currentValueController.value!,
          description: descriptionController.text,
          subject: Subject(id: subjectController.text),
          targetValue: targetValueController.value!);

  @override
  List<String> get errorMesseges => [
        if (titleController.text.isEmpty) "Title cannot be empty",
        if (targetValueController.value == null) "A target value is neccessary",
        if (currentValueController.value == null) "A current value is neccessary"
      ];
}
