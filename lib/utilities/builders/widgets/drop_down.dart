import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class DropDown extends StatefulWidget {
  final DropDownController controller;

  const DropDown({super.key, required this.controller});

  @override
  State<DropDown> createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: DropdownButton<DropDownData>(
          underline: const SizedBox(),
          isExpanded: true,
          isDense: true,
          value: widget.controller.selectedOption,
          elevation: 16,
          onChanged: (DropDownData? newValue) {
            setState(() {
              widget.controller.selectedOption = newValue!;
              widget.controller
                  .onOptionSelected(widget.controller.selectedOption!);
            });
          },
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: widget.controller.options
              .map<DropdownMenuItem<DropDownData>>((DropDownData value) {
            return DropdownMenuItem(
              value: value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (value.image != null)
                    SocialUtilImageProvider(
                      defaultImage: /*DefaultImageManager.user*/ null,
                      image: value.image,
                      radius: 12,
                    ),
                  if (value.iconData != null)
                    Icon(value.iconData, color: ThemeService.eventColor),
                  if (value.image != null || value.iconData != null)
                    const SizedBox(
                      width: 10,
                    ),
                  Text(
                    value.title,
                    style: const TextStyle(fontSize: 15),
                  ),
                  if (value.extra != null)
                    Text(
                      " | ${value.extra}",
                      style: const TextStyle(color: Colors.black54, fontSize: 11),
                    )
                ],
              ),
            );
          }).toList(),
        ));
  }
}