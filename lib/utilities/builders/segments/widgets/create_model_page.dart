// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreateModelPage<T extends Model> extends StatefulWidget {
  const CreateModelPage(
      {super.key,
      required this.controller,
      required this.segments,
      required this.warningsController,
      required this.buttonChildren,
      required this.pageTitle,
      required this.detailPage,
      this.errorMessage = "Paylaşım tamamlanamadı",
      this.successMessage = "Paylaşıldı!",
      this.userIsLoggedIn});
  final BuilderPublisher<T> controller;
  final BuilderWarningsController warningsController;
  final List<CreatePageSegment> Function() segments;
  final Future<bool> Function()? userIsLoggedIn;
  final List<Widget> buttonChildren;
  final String pageTitle;
  final Widget Function(T item) detailPage;
  final String errorMessage;
  final String successMessage;

  @override
  State<CreateModelPage<T>> createState() => _CreateModelPageState<T>();
}

class _CreateModelPageState<T extends Model> extends State<CreateModelPage<T>> {
  List<CreatePageSegment> _segments = [];
  bool _isLoading = false;
  bool _loggedIn = false;

  Future<void> _getUser() async {
    _isLoading = true;
    setState(() {});

    _loggedIn =
        widget.userIsLoggedIn == null ? true : await widget.userIsLoggedIn!();

    if (_loggedIn) _segments = widget.segments();

    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getUser();
    });
  }

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: widget.pageTitle,
        body: !_loggedIn
            ? const Center(
                child: Text("You need to login first",
                    style: TextStyle(color: ThemeService.secondaryText)),
              )
            : Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getResponsiveMarginWidth(context)),
                child: BuilderWarnings(
                  controller: widget.warningsController,
                  builder: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        children: [
                          StickyHeader(
                              header: CreatePageSegmentIndicators(
                                segments: _segments,
                                selectedIndex: _selectedPage,
                                onSelect: (index) => setState(() {
                                  _selectedPage = index;
                                }),
                              ),
                              content: _segments[_selectedPage]),
                          const SizedBox(height: 60)
                        ],
                      ),
                      SocialUtilCard(
                          margin: EdgeInsets.zero,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(
                                  ThemeService.borderRadiusValue)),
                          padding: const EdgeInsets.all(10),
                          background: ThemeService.eventColor,
                          height: 60,
                          child: InkWell(
                            onTap: _isLoading
                                ? null
                                : () async {
                                    _isLoading = true;
                                    setState(() {});
                                    print("context$context");
                                    final item =
                                        await widget.controller.onDone();

                                    await showSocialUtilSnackbar(
                                        context: context,
                                        message: item == null
                                            ? widget.errorMessage
                                            : widget.successMessage,
                                        type: item == null
                                            ? DisplayMessageType.danger
                                            : DisplayMessageType.success);
                                    print("item is right here$item");
                                    if (item != null) {
                                      closePage(context);
                                      launchPage(
                                          context, (widget.detailPage)(item));
                                    }
                                    _isLoading = false;
                                    setState(() {});
                                  },
                            child: _isLoading
                                ? const LoadingIndicator()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: widget.buttonChildren,
                                  ),
                          ))
                    ],
                  ),
                ),
              ));
  }
}
