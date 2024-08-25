// ignore_for_file: use_build_context_synchronously

import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const AppPage(
      {Key? key,
      required this.title,
      required this.body,
      this.canPrev = true,
      this.actions = const [],
      this.canPop})
      : super(key: key);
  final String title;
  final Widget body;
  final bool canPrev;
  final Future<bool> Function()? canPop;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: canPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: !canPrev
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: ThemeService.unusedColor,
                  ),
                  onPressed: () async {
                    if ((canPop != null && (await canPop!())) ||
                        canPop == null) {
                      closePage(context);
                    }
                  },
                ),
          actions: actions,
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(
                color: ThemeService.primaryText,
                fontFamily: ThemeService.headlineFont,
              )),
        ),
        body: body,
      ),
    );
  }
}
