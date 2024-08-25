import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class BuilderSelectedValue extends StatefulWidget {
  const BuilderSelectedValue(
      {super.key, required this.currentNotifier, required this.targetNotifier});
  final ValueNotifier<double?> currentNotifier;
  final ValueNotifier<double?> targetNotifier;

  @override
  State<BuilderSelectedValue> createState() => _BuilderSelectedValueState();
}

class _BuilderSelectedValueState extends State<BuilderSelectedValue> {
  late final _currentController =
      TextEditingController(text: widget.currentNotifier.value?.toString());
  late final _targetController =
      TextEditingController(text: widget.targetNotifier.value?.toString());

  String? _currentError;
  String? _targetError;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.currentNotifier.value != null &&
            widget.targetNotifier.value != null) ...[
          ClipRRect(
            borderRadius: ThemeService.allAroundBorderRadius,
            child: LinearProgressIndicator(
              value:
                  widget.currentNotifier.value! / widget.targetNotifier.value!,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 10),
        ],
        RoundedTextField(
            error: _currentError,
            onChanged: (value) {
              if (value.isEmpty) {
                _currentError = null;
                widget.currentNotifier.value = null;
                setState(() {});
                return;
              }
              final parsed = double.tryParse(value);
              if (parsed == null) {
                _currentError = "Enter a valid decimal!";
              } else {
                _currentError = null;
              }

              widget.currentNotifier.value = parsed;
              setState(() {});
            },
            canClear: false,
            type: TextInputType.text,
            controller: _currentController,
            hint: "Enter current value"),
        const SizedBox(height: 10),
        RoundedTextField(
            error: _targetError,
            onChanged: (value) {
              if (value.isEmpty) {
                _targetError = null;
                widget.targetNotifier.value = null;
                setState(() {});
                return;
              }
              final parsed = double.tryParse(value);
              if (parsed == null) {
                _targetError = "Enter a valid decimal!";
              } else {
                _targetError = null;
              }

              widget.targetNotifier.value = parsed;
              setState(() {});
            },
            canClear: false,
            type: TextInputType.text,
            controller: _targetController,
            hint: "Enter target value"),
      ],
    );
  }
}
