import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ShareButton extends StatefulWidget {
  const ShareButton(
      {Key? key,
      this.showTitle = false,
      required this.shareableId,
      this.color,
      required this.type,
      required this.onTap})
      : super(key: key);
  final bool showTitle;
  final int shareableId;
  final String type;
  final void Function(String type, int id) onTap;
  final Color? color;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.type, widget.shareableId),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(LineIcons.share, size: 25, color: widget.color),
            if (widget.showTitle)
              Text(
                "Paylaş",
                style: TextStyle(fontSize: 9, color: widget.color),
              )
          ],
        ),
      ),
    );
  }
}
