import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class LinkController {
  const LinkController({required this.textEditingController});

  final TextEditingController textEditingController;

  String get link => textEditingController.text;

  set link(String value) {
    textEditingController.text = value;
  }

  static bool isUrlValid(String url) {
    return AnyLinkPreview.isValidLink(
      url,
    );
  }
}