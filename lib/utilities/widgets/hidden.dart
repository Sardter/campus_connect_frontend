import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class Hiddeble extends StatefulWidget {
  const Hiddeble(
      {Key? key,
      required this.child,
      required this.onHide,
      this.height,
      required this.isHidden})
      : super(key: key);
  final Widget child;
  final Future<bool> Function() onHide;
  final double? height;
  final ValueNotifier<bool> isHidden;

  @override
  State<Hiddeble> createState() => HiddebleState();
}

class HiddebleState extends State<Hiddeble> {
  Future<void> toggleHide() async {
    if (await widget.onHide()) {
      widget.isHidden.value = !widget.isHidden.value;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.isHidden,
        builder: (context, value, _) => !value
            ? widget.child
            : GestureDetector(
                onTap: () => toggleHide(),
                child: SocialUtilCard(
                  height: widget.height ?? 200,
                  margin: EdgeInsets.symmetric(
                      horizontal: getResponsiveMarginWidth(context)),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.hide_source,
                            color: ThemeService.unusedColor),
                        Text("Hidden",
                            style: TextStyle(
                                fontSize: 15, color: ThemeService.unusedColor)),
                        Text("Tap to unhide",
                            style: TextStyle(
                                fontSize: 9, color: ThemeService.unusedColor))
                      ]),
                ),
              ));
  }
}
