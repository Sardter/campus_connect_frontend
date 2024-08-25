import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/items/widgets/components/item.dart';
import 'package:campus_connect_frontend/posts/widgets/widgets.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

import '../../../courses/widgets/components/course.dart';

class BorrowableWidget extends StatelessWidget {
  const BorrowableWidget({super.key, required this.borrowable, required this.isDetail});
  final Borrowable borrowable;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runAlignment: WrapAlignment.end,
            children: [
              if (borrowable.item != null) ItemWidget(item: borrowable.item!),
              if (borrowable.course != null)
                CourseWidget(course: borrowable.course!),
            ],
          ),
          const SizedBox(height: 5),
          if (borrowable.duration != null)
            Row(
              children: [
                const Icon(Icons.timer_outlined),
                const SizedBox(width: 5),
                Text(prettyDuration(borrowable.duration!))
              ],
            ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.currency_lira),
              Text(
                borrowable.price != null && borrowable.price!.toDouble() != 0
                    ? getPriceString(borrowable.price!)
                    : "Free",
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 5),
          PostButtons(
            post: borrowable,
            reachToAuthorIcon: Icons.handshake_rounded,
            reachToAuthorTitle: "Borrow",
            isDetail: isDetail,
            postService: ServiceFactory.borrowableService,
          )
        ],
      ),
    );
  }
}
