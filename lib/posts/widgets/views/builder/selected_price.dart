import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class BuilderSelectedPrice extends StatefulWidget {
  const BuilderSelectedPrice({super.key, required this.notifier});
  final ValueNotifier<Decimal?> notifier;

  @override
  State<BuilderSelectedPrice> createState() => _BuilderSelectedPriceState();
}

class _BuilderSelectedPriceState extends State<BuilderSelectedPrice> {
  late final _controller =
      TextEditingController(text: widget.notifier.value?.toString());

  String? _error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
        error: _error,
        onChanged: (value) {
          if (value.isEmpty) {
            _error = null;
            widget.notifier.value = null;
            setState(() {});
            return;
          }
          final parsed = Decimal.tryParse(value);
          if (parsed == null) {
            _error = "Enter a valid decimal!";
          } else {
            _error = null;
          }

          widget.notifier.value = parsed;
          setState(() {});
        },
        canClear: false,
        type: TextInputType.text,
        controller: _controller,
        hint: "Enter Price");
  }
}
