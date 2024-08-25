import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

Future<dynamic> launchModal(BuildContext context, Widget modal) async {
  final heightFactor = ValueNotifier(0.5); // Initial height factor

  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width - (2 * getResponsiveMarginWidth(context)),
    ),
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeService.borderRadiusValue))),
    builder: (context) {
      return ValueListenableBuilder<double>(
        valueListenable: heightFactor,
        builder: (context, value, child) {
          return GestureDetector(
            onVerticalDragUpdate: (details) {
              // Update the height factor based on the drag
              double newValue =
                  value - details.delta.dy / MediaQuery.of(context).size.height;
              // Clamp the value to be within a valid range (e.g., 0.2 to 1.0)
              newValue = newValue.clamp(0.25, 1.0);
              heightFactor.value = newValue; // Update the height factor

              if (newValue <= 0.25) {
                // Minimum value to close the modal
                Navigator.pop(context); // Close the modal
              }
            },
            child: FractionallySizedBox(
              heightFactor: value, // Use the height factor
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ThemeService.unusedColor, width: 0.5))),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Icon(Icons.drag_handle),
                  ), // Drag handle
                  Expanded(child: modal), // ListView or other content
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

/* class ShareOptionsModal extends StatefulWidget {
  const ShareOptionsModal(
      {Key? key,
      required this.shareableId,
      required this.type,
      required this.dynamicLinkService})
      : super(key: key);
  final String type;
  final int shareableId;
  final DynamicLinkService dynamicLinkService;

  @override
  State<ShareOptionsModal> createState() => _ShareOptionsModalState();
}

class _ShareOptionsModalState extends State<ShareOptionsModal> {
  bool _showLinkCopiedIndicator = false;

  Widget _option(String title, Icon icon, Future<void> Function() onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (_showLinkCopiedIndicator) const Icon(LineIcons.check)
          ],
        ),
      ),
    );
  }

  Future<String?> _getLink(context) async {
    final link =
        widget.dynamicLinkService.createLink(widget.type, widget.shareableId);
    return link.toString();
  }

  @override
  Widget build(context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      shrinkWrap: true,
      children: [
        const Text(
          'Paylaş',
          style: TextStyle(fontFamily: 'Quicksand', fontSize: 18),
          textAlign: TextAlign.center,
        ),
        _option(
            "Link Paylaş",
            const Icon(
              LineIcons.link,
              size: 30,
              color: ThemeService.eventColor,
            ), () async {
          Clipboard.setData(ClipboardData(text: (await _getLink(context))!));
          setState(() {
            _showLinkCopiedIndicator = true;
          });
          // ignore: use_build_context_synchronously
          closePage(context);
          //APIService.displaySuccess("Kopyalandı", context);
          await Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _showLinkCopiedIndicator = false;
              });
            }
          });
        }),
        const SizedBox(height: 10)
      ],
    );
  }
} */
