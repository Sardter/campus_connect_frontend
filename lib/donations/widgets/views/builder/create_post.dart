import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateDonation extends StatefulWidget {
  const CreateDonation({super.key, required this.controller});
  final CreateDonationController controller;

  @override
  State<CreateDonation> createState() => _CreateDonationState();
}

class _CreateDonationState extends State<CreateDonation> {
  late final _segments = <CreatePageSegment>[
    CreateDonationDescriptionSegment(
        controller: widget.controller.descriptionController),
    BuilderMediaSegment(mediaController: widget.controller.mediaController)
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Donation>(
      controller: widget.controller,
      segments: () => _segments,
      warningsController: widget.controller.warningsController,
      buttonChildren: const [
        Icon(
          Icons.share,
          color: ThemeService.onContrastColor,
        ),
        SizedBox(width: 10),
        Text(
          "Publish",
          style: TextStyle(color: ThemeService.onContrastColor),
        )
      ],
      pageTitle: "Donation Post Edittor",
      userIsLoggedIn: () => APIAuthServiceFactory.SERVICE.isLogedIn,
      detailPage: (secondHand) => PostDetailPage(
        postService: ServiceFactory.donationService,
        id: secondHand.id,
      ),
    );
  }
}
