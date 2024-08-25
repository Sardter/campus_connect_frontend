import 'package:campus_connect_frontend/items/widgets/components/item.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/services/service_factory.dart';
import 'package:flutter/material.dart';

class LostAndFoundWidget extends StatelessWidget {
  const LostAndFoundWidget(
      {super.key, required this.lostAndFound, required this.isDetail});
  final LostAndFound lostAndFound;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lostAndFound.location != null)
            Row(
              children: [
              if (lostAndFound.item != null) ItemWidget(item: lostAndFound.item!),
            ],
            ),
          const SizedBox(height: 5),
          if (lostAndFound.location != null)
            Row(
              children: [
                const Icon(Icons.map),
                const SizedBox(width: 5),
                Text(lostAndFound.location!)
              ],
            ),
          const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 5),
                Text("${lostAndFound.item?.id}")
              ],
            ),

          const SizedBox(height: 5),
          PostButtons(
            post: lostAndFound,
            reachToAuthorIcon: Icons.back_hand_outlined,
            reachToAuthorTitle: "Retrieve",
            isDetail: isDetail,
            postService: ServiceFactory.lostAndFoundService,
          )
        ],
      ),
    );
  }
}
