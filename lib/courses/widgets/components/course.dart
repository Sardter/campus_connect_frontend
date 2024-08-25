import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return SocialUtilCard(
      boxShadow: Colors.transparent,
      background: const Color.fromARGB(125, 74, 162, 255),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          const Icon(
            LineIcons.book,
            color: ThemeService.onContrastColor,
          ),
          const SizedBox(width: 10),
          Text(course.title,
              style: const TextStyle(color: ThemeService.onContrastColor)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
