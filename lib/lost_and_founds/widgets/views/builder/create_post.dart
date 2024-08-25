import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateLostAndFound extends StatefulWidget {
  const CreateLostAndFound({super.key, required this.controller});
  final CreateLostAndFoundController controller;

  @override
  State<CreateLostAndFound> createState() => _CreateLostAndFoundState();
}

class _CreateLostAndFoundState extends State<CreateLostAndFound> {
  late final _segments = <CreatePageSegment>[
    CreateLostAndFoundDescriptionSegment(
        controller: widget.controller.descriptionController),
    BuilderMediaSegment(mediaController: widget.controller.mediaController)
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<LostAndFound>(
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
      pageTitle: "Lost and Found Post Editor",
      userIsLoggedIn: () => APIAuthServiceFactory.SERVICE.isLogedIn,
      detailPage: (secondHand) => PostDetailPage(
        postService: ServiceFactory.lostAndFoundService,
        id: secondHand.id,
      ),
    );
  }
}
