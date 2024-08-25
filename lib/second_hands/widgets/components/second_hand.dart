import 'package:campus_connect_frontend/courses/widgets/components/components.dart';
import 'package:campus_connect_frontend/items/widgets/components/item.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class SecondHandWidget extends StatelessWidget {
  const SecondHandWidget(
      {super.key, required this.secondHand, required this.isDetail});
  final SecondHand secondHand;
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
              if (secondHand.item != null) ItemWidget(item: secondHand.item!),
              if (secondHand.course != null)
                CourseWidget(course: secondHand.course!),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.currency_lira),
              Text(
                secondHand.price != null && secondHand.price!.toDouble() != 0
                    ? getPriceString(secondHand.price!)
                    : "Free",
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 5),
          PostButtons(
            post: secondHand,
            reachToAuthorIcon: Icons.shopping_bag,
            reachToAuthorTitle: "Buy",
            isDetail: isDetail,
            postService: ServiceFactory.secondHandService,
          )
        ],
      ),
    );
  }
}
