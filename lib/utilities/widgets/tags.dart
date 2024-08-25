import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({super.key, required this.tags, this.onDelete});

  final List<String> tags;
  final void Function(int index)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        children: List.generate(
            tags.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Chip(
                      label: Text(tags[index]),
                      avatar: const Icon(LineIcons.hashtag),
                      onDeleted:
                          onDelete == null ? null : () => onDelete!(index++),
                      deleteIcon: const Icon(LineIcons.times,
                          color: ThemeService.secondaryText),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                )),
      ),
    );
  }
}
