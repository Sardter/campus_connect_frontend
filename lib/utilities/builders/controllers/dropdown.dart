import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class DropDownData<T> {
  final int id;
  final String title;
  final T value;
  final ImageData? image;
  final IconData? iconData;
  final String? extra;

  const DropDownData(
      {required this.title,
      required this.id,
      required this.value,
      this.image,
      this.iconData,
      this.extra});
}

class DropDownController<T> {
  final List<DropDownData<T>> options;
  DropDownData<T>? selectedOption;
  final void Function(DropDownData selectedValue) onOptionSelected;

  DropDownController(
      {required this.options,
      required this.onOptionSelected,
      this.selectedOption,
      int? index}) {
    if (index != null) {
      for (var i = 0; i < options.length; i++) {
        if (options[i].id == index) {
          selectedOption = options[i];
        }
      }
    }
  }
}