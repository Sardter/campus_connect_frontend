import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateDonationDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateDonationDescriptionSegment({super.key, required this.controller});
  final CreateDonationDescriptionController controller;

  @override
  State<CreateDonationDescriptionSegment> createState() =>
      _CreateDonationDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Details";
}

class _CreateDonationDescriptionSegmentState
    extends State<CreateDonationDescriptionSegment> {
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
          BuilderSelectedValue(
              currentNotifier: widget.controller.currentValueController,
              targetNotifier: widget.controller.targetValueController),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.subjectController,
              hint: "Subject")
        ],
      ),
    );
  }
}
