import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class BuilderWarning extends StatelessWidget {
  const BuilderWarning(
      {Key? key,
      required this.id,
      required this.errorMessage,
      required this.onDismissed})
      : super(key: key);
  final int id;
  final String errorMessage;
  final void Function(int id) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => onDismissed(id),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: ThemeService.allAroundBorderRadius),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(LineIcons.exclamationCircle, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.white))),
              IconButton(
                  onPressed: () => onDismissed(id),
                  icon: const Icon(LineIcons.times, color: Colors.white54))
            ],
          ),
        ));
  }
}