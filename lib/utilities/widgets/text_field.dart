import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class RoundedTextField extends StatefulWidget {
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmit;
  final TextInputType type;
  final TextEditingController controller;
  final String hint;
  final Color? backgroundColor;
  final bool canClear;
  final bool editable;
  final bool showCursor;
  final double? fontSize;
  final EdgeInsets? padding;
  final void Function()? onClear;
  final int? minLines;
  final String? error;
  final bool autoFoucs;
  final bool showEditableColor;
  final FocusNode? focusNode;
  final List<Widget> prefix;
  final List<Widget> suffix;
  final double? height;
  final BorderRadius? borderRadius;
  final bool obscureText;

  final bool isMultiLine;
  const RoundedTextField(
      {Key? key,
      this.onChanged,
      this.onSubmit,
      this.isMultiLine = false,
      required this.type,
      this.backgroundColor,
      this.editable = true,
      required this.controller,
      this.canClear = true,
      this.fontSize,
      this.obscureText = false,
      this.prefix = const [],
      this.suffix = const [],
      this.autoFoucs = false,
      this.showEditableColor = true,
      this.height,
      this.error,
      this.showCursor = true,
      this.focusNode,
      this.minLines,
      this.onClear,
      this.borderRadius,
      this.padding,
      required this.hint})
      : assert((isMultiLine && type == TextInputType.multiline) ||
            (!isMultiLine && type != TextInputType.multiline)),
        super(key: key);

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  void _clear() {
    setState(() {
      widget.controller.clear();
      if (widget.onClear != null) widget.onClear!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              widget.borderRadius ?? ThemeService.allAroundBorderRadius,
          color: widget.backgroundColor ?? ThemeService.textField),
      height: widget.height,
      alignment: Alignment.center,
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.prefix,
          Expanded(
            child: IgnorePointer(
              ignoring: !widget.editable,
              child: TextFormField(
                controller: widget.controller,
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                  setState(() {});
                },
                minLines: widget.minLines ?? 1,
                maxLines: widget.isMultiLine ? null : 1,
                showCursor: widget.showCursor,
                keyboardType: widget.type,
                enabled: widget.showEditableColor ? widget.editable : true,
                focusNode: widget.focusNode,
                autofocus: widget.autoFoucs,
                obscureText: widget.obscureText,
                style: TextStyle(fontSize: widget.fontSize),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hint,
                    errorText: widget.error,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none),
                onEditingComplete: widget.onSubmit == null
                    ? null
                    : () => widget.onSubmit!(widget.controller.text),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty && widget.canClear)
            GestureDetector(
              onTap: () {
                _clear();
                if (widget.onChanged != null) widget.onChanged!("");
                setState(() {});
              },
              child: const Icon(Icons.close),
            ),
          ...widget.suffix
        ],
      ),
    );
  }
}
