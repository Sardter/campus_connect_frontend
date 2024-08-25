import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateLostAndFoundDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateLostAndFoundDescriptionSegment(
      {super.key, required this.controller});
  final CreateLostAndFoundDescriptionController controller;

  @override
  State<CreateLostAndFoundDescriptionSegment> createState() =>
      _CreateLostAndFoundDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Details";
}

class _CreateLostAndFoundDescriptionSegmentState
    extends State<CreateLostAndFoundDescriptionSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.titleController,
              hint: "Title"),
          const SizedBox(height: 15),
          RoundedTextField(
            type: TextInputType.multiline,
            controller: widget.controller.descriptionController,
            hint: "Description",
            isMultiLine: true,
            minLines: 10,
          ),
          const SizedBox(height: 15),
          RoundedTextField(
            type: TextInputType.multiline,
            controller: widget.controller.locationController,
            hint: "Location",
            isMultiLine: true,
            minLines: 10,
          ),
          const SizedBox(height: 15),
          RoundedTextField(
            type: TextInputType.text,
            controller: widget.controller.itemController,
            hint: "Item"
          ),
        ],
      ),
    );
  }
}
