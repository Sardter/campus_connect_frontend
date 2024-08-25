
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/builders/builders.dart';

class BuilderWarnings extends StatefulWidget {
  const BuilderWarnings(
      {Key? key, required this.controller, required this.builder})
      : super(key: key);
  final BuilderWarningsController controller;
  final Widget builder;

  @override
  State<BuilderWarnings> createState() => _BuilderWarningsState();
}

class _BuilderWarningsState extends State<BuilderWarnings> {
  int _id = 0;

  @override
  void initState() {
    widget.controller.onError = _onAdd;
    super.initState();
  }

  void _onAdd(String errorMessage) {
    setState(() {
      widget.controller.warnings.add(BuilderWarning(
          id: _id++, errorMessage: errorMessage, onDismissed: _onDismissed));
    });
  }

  void _onDismissed(int id) {
    setState(() {
      widget.controller.warnings.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder,
        Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.controller.warnings,
            ))
      ],
    );
  }
}