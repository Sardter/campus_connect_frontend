import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/subjects/widgets/widgets.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class DonationWidget extends StatelessWidget {
  const DonationWidget(
      {super.key, required this.donation, required this.isDetail});
  final Donation donation;
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
              if (donation.subject != null)
                SubjectWidget(subject: donation.subject!)
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: ThemeService.allAroundBorderRadius,
            child: LinearProgressIndicator(
              value: donation.currentValue / donation.targetValue,
              minHeight: 10,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${donation.currentValue}/${donation.targetValue}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          PostButtons(
            post: donation,
            reachToAuthorIcon: Icons.back_hand_outlined,
            reachToAuthorTitle: "Donate",
            isDetail: isDetail,
            postService: ServiceFactory.donationService,
          )
        ],
      ),
    );
  }
}
