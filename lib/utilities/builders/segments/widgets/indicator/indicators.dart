import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreatePageSegmentIndicators extends StatelessWidget {
  const CreatePageSegmentIndicators(
      {super.key,
      required this.segments,
      required this.selectedIndex,
      required this.onSelect});
  final List<CreatePageSegment> segments;
  final int selectedIndex;
  final void Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(top: 10, left: 10),
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
            segments.length,
            (index) => GestureDetector(
                  onTap: () => onSelect(index),
                  child: CreatePageSegmentIndicator(
                    segment: segments[index],
                    selected: index == selectedIndex,
                  ),
                )),
      ),
    );
  }
}