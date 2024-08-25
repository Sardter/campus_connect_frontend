import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SocialUtilButton extends StatefulWidget {
  const SocialUtilButton(
      {Key? key,
      required this.children,
      this.maximizeLength = false,
      this.enabled = true,
      this.color = const Color.fromARGB(255, 34, 158, 252),
      this.initialActivation = false,
      required this.onTap})
      : super(key: key);
  final List<Widget> children;
  final bool maximizeLength;
  final bool enabled;
  final bool initialActivation;
  final Future<bool> Function()? onTap;
  final Color color;

  @override
  State<SocialUtilButton> createState() => _SocialUtilButtonState();
}

class _SocialUtilButtonState extends State<SocialUtilButton> {
  late bool _activited = widget.initialActivation;
  bool _busy = false;

  Future<void> _onTap() async {
    setState(() {
      _busy = true;
    });
    final result = await widget.onTap!();
    if (mounted) {
      setState(() {
        _activited = result;
        _busy = false;
      });
    }
  }

  Row _child() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: widget.maximizeLength ? MainAxisSize.max : MainAxisSize.min,
      children: _busy ? [const LoadingIndicator(radius: 5)] : widget.children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: _activited || _busy
          ? OutlinedButton(
              onPressed: !widget.enabled
                  ? null
                  : widget.onTap != null
                      ? _onTap
                      : null,
              style: OutlinedButton.styleFrom(
                  foregroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: _child())
          : OutlinedButton(
              onPressed: !widget.enabled
                  ? null
                  : widget.onTap != null
                      ? _onTap
                      : null,
              style: OutlinedButton.styleFrom(
                  foregroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: _child()),
    );
  }
}
