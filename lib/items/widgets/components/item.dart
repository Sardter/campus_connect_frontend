import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return SocialUtilCard(
      boxShadow: Colors.transparent,
      height: 35,
      background: const Color.fromARGB(123, 25, 167, 46),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          Text(item.title,
              style: const TextStyle(color: ThemeService.onContrastColor)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
