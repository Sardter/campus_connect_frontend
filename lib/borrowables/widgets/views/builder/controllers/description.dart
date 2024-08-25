import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CreateBorrowableDescriptionData {
  final String title;
  final String description;
  final Decimal? price;
  final Course? course;
  final Item? item;

  const CreateBorrowableDescriptionData(
      {required this.title,
      required this.description,
      required this.price,
      required this.course,
      required this.item});
}

class CreateBorrowableDescriptionController
    extends BuilderSegmentController<CreateBorrowableDescriptionData> {
  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialDescription;
  final Decimal? initialPrice;
  final Course? initialCourse;
  final Item? initialItem;
  final DateTime? intialStartDate;
  final DateTime? intialEndDate;

  CreateBorrowableDescriptionController(
      {required this.warningsController,
      this.initialTitle,
      this.initialDescription,
      this.initialPrice,
      this.intialStartDate,
      this.intialEndDate,
      this.initialCourse,
      this.initialItem});

  late final titleController = TextEditingController(text: initialTitle);
  late final descriptionController =
      TextEditingController(text: initialDescription);
  late final priceController = ValueNotifier<Decimal?>(initialPrice);
  late final courseController = TextEditingController(text: initialCourse?.id);
  late final itemController = TextEditingController(text: initialItem?.id);

  @override
  CreateBorrowableDescriptionData? get data => !isValid
      ? null
      : CreateBorrowableDescriptionData(
          title: titleController.text,
          description: descriptionController.text,
          price: priceController.value,
          course: Course(id: courseController.text),
          item: Item(id: itemController.text));

  @override
  List<String> get errorMesseges => [
        if (titleController.text.isEmpty) "Title cannot be empty",
        if (priceController.value != null &&
            priceController.value!.toDouble() < 0)
          "Price cannot be negative"
      ];
}
