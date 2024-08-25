import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateBorrowable extends StatefulWidget {
  const CreateBorrowable({super.key, required this.controller});
  final CreateBorrwableController controller;

  @override
  State<CreateBorrowable> createState() => _CreateBorrowableState();
}

class _CreateBorrowableState extends State<CreateBorrowable> {
  late final _segments = <CreatePageSegment>[
    CreateBorrowableDescriptionSegment(
        controller: widget.controller.descriptionController),
    BuilderMediaSegment(mediaController: widget.controller.mediaController),
    BuilderDateSegment(dateController: widget.controller.dateController)
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Borrowable>(
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
      pageTitle: "Borrowable Post Edittor",
      userIsLoggedIn: () => APIAuthServiceFactory.SERVICE.isLogedIn,
      detailPage: (secondHand) => PostDetailPage(
        postService: ServiceFactory.borrowableService,
        id: secondHand.id,
      ),
    );
  }
}
