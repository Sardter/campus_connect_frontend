import 'package:flutter/material.dart';

import '../services/services.dart';

class SocialUtilCheckBoxController {
  SocialUtilCheckBoxController(
      {bool toggled = false, this.onToggle, this.editable = true}) {
    this.toggled = ValueNotifier(toggled);
  }
  final void Function()? onToggle;
  late final ValueNotifier<bool> toggled;
  final bool editable;

  void toggle(bool? value, {bool byPassOnToggle = false}) {
    if (!editable) return;
    if (onToggle != null && !byPassOnToggle) onToggle!();
    if (value != null) toggled.value = value;
  }
}

class SocialUtilCheckBox extends StatefulWidget {
  const SocialUtilCheckBox(
      {Key? key, required this.children, required this.controller})
      : super(key: key);
  final List<Widget> children;
  final SocialUtilCheckBoxController controller;

  @override
  State<SocialUtilCheckBox> createState() => _SocialUtilCheckBoxState();
}

class _SocialUtilCheckBoxState extends State<SocialUtilCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          activeColor: ThemeService.eventColor,
          shape: const CircleBorder(),
          value: widget.controller.toggled.value,
          onChanged: (value) =>
              setState(() => widget.controller.toggle(value))),
      ...widget.children.map((e) => Flexible(child: e)),
    ]);
  }
}