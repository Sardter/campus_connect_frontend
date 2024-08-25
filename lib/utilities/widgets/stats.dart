import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class Stats extends StatelessWidget {
  const Stats({super.key, required this.items});
  final List<StatsItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
    );
  }
}

class StatsItem extends StatelessWidget {
  const StatsItem({
    super.key,
    required this.icon,
    required this.name,
    required this.count,
    required this.onTap,
    this.hasMedia = false,
  });

  final IconData icon;
  final String name;
  final int count;
  final void Function() onTap;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //widthFactor: 0.3,
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getShortNumber(count),
                maxLines: 1,
                style: TextStyle(
                    color: hasMedia ? ThemeService.onContrastColor : null,
                    fontFamily: ThemeService.headlineFont, fontSize: 20),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 12, color: hasMedia ? ThemeService.onContrastColor : null,),
                  const SizedBox(width: 5),
                  Text(name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: hasMedia ? ThemeService.onContrastColor : null,
                          fontFamily: ThemeService.headlineFont, fontSize: 12))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}