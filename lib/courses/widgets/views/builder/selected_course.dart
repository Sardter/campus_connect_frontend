import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/modals/modals.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BuilderSelectedCourse extends StatefulWidget {
  const BuilderSelectedCourse({super.key, required this.notifier});
  final ValueNotifier<Course?> notifier;

  @override
  State<BuilderSelectedCourse> createState() => _BuilderSelectedCourseState();
}

class _BuilderSelectedCourseState extends State<BuilderSelectedCourse> {
  final _courseManager = ServiceFactory.courseService;

  List<Course> _courses = [];

  Future<void> _getCourses() async {
    _courses = (await _courseManager.getList())!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Course?>(
        valueListenable: widget.notifier,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              launchModal(
                context,
                ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => setState(() {
                            widget.notifier.value = _courses[index];
                            closePage(context);
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ThemeService.clubColor,
                              borderRadius: ThemeService.allAroundBorderRadius
                            ),
                            child: Row(children: [
                              const Icon(LineIcons.book,color: ThemeService.onContrastColor),
                              Text(_courses[index].title, style: const TextStyle(color: ThemeService.onContrastColor),)
                            ]),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _courses.length),
              );
            },
            child: AbsorbPointer(
              child: RoundedTextField(
                  type: TextInputType.none,
                  controller: TextEditingController(text: value?.title),
                  hint: "Course",
                  canClear: false,
                  prefix: [
                    if (value != null) ...[
                      const Icon(LineIcons.book),
                      const SizedBox(width: 10)
                    ]
                  ]),
            ),
          );
        });
  }
}
