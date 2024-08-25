import 'package:flutter/material.dart';

abstract class CreatePageSegment extends Widget {
  const CreatePageSegment({super.key});

  String get label;
  IconData get icon;
}