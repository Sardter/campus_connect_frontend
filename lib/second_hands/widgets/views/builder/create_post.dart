import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateSecondHand extends StatefulWidget {
  const CreateSecondHand({super.key, required this.controller});
  final CreateSecondHandController controller;

  @override
  State<CreateSecondHand> createState() => _CreateSecondHandState();
}

class _CreateSecondHandState extends State<CreateSecondHand> {
  late final _segments = <CreatePageSegment>[
    CreateSecondHandDescriptionSegment(
        controller: widget.controller.descriptionController),
    BuilderMediaSegment(mediaController: widget.controller.mediaController)
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<SecondHand>(
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
      userIsLoggedIn: () => APIAuthServiceFactory.SERVICE.isLogedIn,
      pageTitle: "Second Hand Post Edittor",
      detailPage: (secondHand) => PostDetailPage(
        postService: ServiceFactory.secondHandService,
        id: secondHand.id,
      ),
    );
  }
}
