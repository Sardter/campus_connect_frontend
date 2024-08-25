import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/items/widgets/components/item.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class FiltersController {
  void Function()? onToggle;

  final course = ValueNotifier<String?>(null);
  final subject = ValueNotifier<String?>(null);
}

enum FilterType { course, subject }

class SelectedFilter extends StatefulWidget {
  const SelectedFilter(
      {super.key,
      required this.item,
      required this.controller,
      required this.type});
  final String item;
  final FiltersController controller;
  final FilterType type;

  @override
  State<SelectedFilter> createState() => _SelectedFilterState();
}

class _SelectedFilterState extends State<SelectedFilter> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.type == FilterType.course
            ? widget.controller.course
            : widget.controller.subject,
        builder: (context, value, _) => InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                if (widget.type == FilterType.course) {
                  if (value == widget.item) {
                    widget.controller.course.value = null;
                  } else {
                    widget.controller.course.value = widget.item;
                  }
                } else {
                  if (value == widget.item) {
                    widget.controller.subject.value = null;
                  } else {
                    widget.controller.subject.value = widget.item;
                  }
                }
                if (widget.controller.onToggle != null) {
                  widget.controller.onToggle!();
                }
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: (widget.type == FilterType.course &&
                                value == widget.item) ||
                            (widget.type == FilterType.subject &&
                                value == widget.item)
                        ? Border.all(color: ThemeService.clubColor, width: 2)
                        : null),
                child: ItemWidget(item: Item(id: widget.item)),
              ),
            ));
  }
}

class FiltersVierw extends StatefulWidget {
  const FiltersVierw({super.key, required this.controller});
  final FiltersController controller;

  @override
  State<FiltersVierw> createState() => _FiltersVierwState();
}

class _FiltersVierwState extends State<FiltersVierw> {
  final _searchController = TextEditingController();

  List<String> _subjects = [];
  List<String> _courses = [];

  Future<void> _getItems() async {
    final objects = await APIServiceFactory.SERVICE.actionAndGetResponseItems(
        url: "https://api.campusconnect.yuiozasx.com/courses_and_subjects/",
        authService: APIAuthServiceFactory.SERVICE);

    _subjects = objects['subjects'].cast<String>() ?? [];
    _courses = objects['courses'].cast<String>() ?? [];

    _subjects = _subjects
        .where((element) => element
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
    _courses = _courses
        .where((element) => element
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          RoundedTextField(
              type: TextInputType.text,
              controller: _searchController,
              onChanged: (value) {
                _getItems();
              },
              hint: "Search"),
          const SizedBox(height: 20),
          const Text("Subjects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          Wrap(
            children: _subjects
                .map((e) => SelectedFilter(
                      item: e,
                      controller: widget.controller,
                      type: FilterType.subject,
                    ))
                .toList(),
          ),
          const Text("Courses",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          Wrap(
            children: _courses
                .map((e) => SelectedFilter(
                      item: e,
                      controller: widget.controller,
                      type: FilterType.course,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
