import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

enum DisplayMessageType { none, success, danger }

Future<void> showSocialUtilSnackbar(
    {required BuildContext context,
    required String message,
    DisplayMessageType type = DisplayMessageType.none}) async {
  Color color() {
    switch (type) {
      case DisplayMessageType.none:
        return ThemeService.menuBackground;
      case DisplayMessageType.danger:
        return Colors.red;
      case DisplayMessageType.success:
        return Colors.green;
    }
  }

  final flushbar = Flushbar(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: getResponsiveMarginWidth(context) + 10),
    borderRadius: ThemeService.allAroundBorderRadius,
    backgroundColor: ThemeService.menuBackground,
    backgroundGradient:
        LinearGradient(colors: [color(), color().withOpacity(0.9)]),
    messageColor: type == DisplayMessageType.none
        ? ThemeService.primaryText
        : ThemeService.onContrastColor,
    message: message,
    duration: const Duration(seconds: 3),
  );

  await flushbar.show(context);

  /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(color: ThemeService.primaryText)),
    backgroundColor: _color(),
  )); */
}

Future<bool?> launchConfirmationDialog(
    BuildContext context, String message) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: ThemeService.allAroundBorderRadius),
            backgroundColor: ThemeService.menuBackground,
            title: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: ThemeService.secondaryText),
                  )),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: ThemeService.eventColor),
                  )),
            ],
          ));
}

Future<bool?> launchTextConfirmationDialog(BuildContext context, String message,
    TextEditingController controller, String hint) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: ThemeService.allAroundBorderRadius),
            backgroundColor: ThemeService.menuBackground,
            title: Text(message),
            content: Container(
              height: 200,
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: RoundedTextField(
                  type: TextInputType.multiline,
                  height: 200,
                  isMultiLine: true,
                  controller: controller,
                  hint: hint,
                  minLines: 2),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: ThemeService.secondaryText),
                  )),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: ThemeService.eventColor),
                  )),
            ],
          ));
}
