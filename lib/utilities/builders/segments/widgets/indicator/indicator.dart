import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreatePageSegmentIndicator extends StatelessWidget {
  const CreatePageSegmentIndicator(
      {super.key, required this.segment, this.selected = false});
  final CreatePageSegment segment;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Icon(segment.icon,
                    color: selected ? ThemeService.eventColor : null),
                const SizedBox(width: 10),
                Text(
                  segment.label,
                  style: TextStyle(
                      color: selected ? ThemeService.eventColor : null),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: ThemeService.allAroundBorderRadius,
                  color: selected ? ThemeService.eventColor : null),
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}