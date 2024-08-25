import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateBorrowableDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateBorrowableDescriptionSegment(
      {super.key, required this.controller});
  final CreateBorrowableDescriptionController controller;

  @override
  State<CreateBorrowableDescriptionSegment> createState() =>
      _CreateBorrowableDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Details";
}

class _CreateBorrowableDescriptionSegmentState
    extends State<CreateBorrowableDescriptionSegment> {
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
          BuilderSelectedPrice(notifier: widget.controller.priceController),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.itemController,
              hint: "Item"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.controller.courseController,
              hint: "Course"),
        ],
      ),
    );
  }
}
