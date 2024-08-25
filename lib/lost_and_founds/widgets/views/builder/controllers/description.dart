import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateLostAndFoundDescriptionData {
  final String title;
  final String description;
  final String? location;
  final Item? item;

  const CreateLostAndFoundDescriptionData(
      {required this.title,
      required this.description,
      required this.location,
      required this.item});
}

class CreateLostAndFoundDescriptionController
    extends BuilderSegmentController<CreateLostAndFoundDescriptionData> {
  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialDescription;
  final String? initialLocation;
  final Item? initialItem;

  CreateLostAndFoundDescriptionController(
      {required this.warningsController,
      this.initialTitle,
      this.initialDescription,
      this.initialLocation,
      this.initialItem});

  late final titleController = TextEditingController(text: initialTitle);
  late final descriptionController =
      TextEditingController(text: initialDescription);
  late final itemController = TextEditingController(text: initialItem?.id);
  late final locationController =
      TextEditingController(text: initialLocation);

  @override
  CreateLostAndFoundDescriptionData? get data => !isValid
      ? null
      : CreateLostAndFoundDescriptionData(
          title: titleController.text,
          description: descriptionController.text,
          location: locationController.text,
          item: Item(id: itemController.text));

  @override
  List<String> get errorMesseges => [
        if (titleController.text.isEmpty) "Title cannot be empty",
      ];
}
