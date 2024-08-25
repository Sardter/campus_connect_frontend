import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class SocialUtilIconButton extends StatefulWidget {
  const SocialUtilIconButton(
      {Key? key,
      this.title,
      required this.icon,
      required this.onTap,
      this.color,
      this.display = true,
      this.size,
      this.width})
      : super(key: key);
  final String? title;
  final IconData? icon;
  final void Function()? onTap;
  final bool display;
  final Color? color;
  final double? width;
  final double? size;

  @override
  State<SocialUtilIconButton> createState() => _SocialUtilIconButtonState();
}

class _SocialUtilIconButtonState extends State<SocialUtilIconButton> {
  @override
  Widget build(BuildContext context) {
    return widget.display
        ? InkWell(
            onTap: widget.onTap,
            borderRadius: ThemeService.allAroundBorderRadius,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.color ?? ThemeService.secondaryText),
                  borderRadius: ThemeService.allAroundBorderRadius),
              width: widget.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) Icon(
                    widget.icon,
                    size: widget.size ?? 25,
                    color: widget.color,
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(width: 5),
                    Text(
                      widget.title!,
                      style: TextStyle(fontSize: 12, color: widget.color),
                    )
                  ]
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
