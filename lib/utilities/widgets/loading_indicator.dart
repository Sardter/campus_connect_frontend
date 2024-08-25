import 'package:campus_connect_frontend/utilities/services/services.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.radius = 20});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        constraints:
            BoxConstraints(maxWidth: radius * 2, maxHeight: radius * 2),
        child: const CircularProgressIndicator(
          strokeWidth: 1,
          color: ThemeService.unusedColor,
        ),
      ),
    );
  }
}
