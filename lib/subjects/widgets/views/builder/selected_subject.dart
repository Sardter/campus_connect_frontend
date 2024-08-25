import 'package:campus_connect_frontend/modals/modals.dart';
import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BuilderSelectedSubject extends StatefulWidget {
  const BuilderSelectedSubject({super.key, required this.notifier});
  final ValueNotifier<Subject?> notifier;

  @override
  State<BuilderSelectedSubject> createState() => _BuilderSelectedSubjectState();
}

class _BuilderSelectedSubjectState extends State<BuilderSelectedSubject> {
  final _subjectManager = ServiceFactory.subjectService;

  List<Subject> _subjects = [];

  Future<void> _getSubjects() async {
    _subjects = (await _subjectManager.getList())!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getSubjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Subject?>(
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
                            widget.notifier.value = _subjects[index];
                            closePage(context);
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: ThemeService.clubColor,
                                borderRadius:
                                    ThemeService.allAroundBorderRadius),
                            child: Row(children: [
                              const Icon(LineIcons.podcast,
                                  color: ThemeService.onContrastColor),
                              Text(
                                _subjects[index].title,
                                style: const TextStyle(
                                    color: ThemeService.onContrastColor),
                              )
                            ]),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _subjects.length),
              );
            },
            child: AbsorbPointer(
              child: RoundedTextField(
                  type: TextInputType.none,
                  controller: TextEditingController(text: value?.title),
                  hint: "Subject",
                  canClear: false,
                  prefix: [
                    if (value != null) ...[
                      const Icon(LineIcons.podcast),
                      const SizedBox(width: 10)
                    ]
                  ]),
            ),
          );
        });
  }
}
