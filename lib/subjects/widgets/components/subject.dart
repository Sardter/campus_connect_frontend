import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({super.key, required this.subject});
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return SocialUtilCard(
      boxShadow: Colors.transparent,
      background: const Color.fromARGB(124, 74, 255, 92),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          const Icon(
            LineIcons.book,
            color: ThemeService.onContrastColor,
          ),
          const SizedBox(width: 10),
          Text(subject.title,
              style: const TextStyle(color: ThemeService.onContrastColor)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
