import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget(
      {super.key,
      required this.post,
      required this.postService,
      required this.postWidget});
  final Post post;
  final ModelService<Post> postService;
  final PostWidgetState postWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchPage(
            context,
            ProfilePage(
              id: post.author.id,
            ));
      },
      child: Row(
        children: [
          SocialUtilImageProvider(
              image: post.author.profilePhoto, defaultImage: null),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.author.displayName),
            ],
          ),
          const Spacer(),
          if (post.allowedActions != null)
            AllowedActionsWidget<AllowedActions, Post>(
                actions: post.allowedActions!,
                modelService: postService,
                model: post,
                actionMapper: (actions, context) => [
                      if (actions.canDelete)
                        ActionData(
                            icon: Icons.delete,
                            title: "Delete",
                            onTap: () async {
                              if ((await launchConfirmationDialog(context,
                                          "Do you really want to delete this post?") ??
                                      false) &&
                                  (await postService.deleteItem(
                                          itemParameters:
                                              ItemParameters(id: post.id)) != null)) {
                                // ignore: use_build_context_synchronously
                                showSocialUtilSnackbar(
                                    context: context,
                                    message: "Post deleted",
                                    type: DisplayMessageType.success);
                              }
                            }),
                      if (actions.canHide)
                        ActionData(
                            icon: Icons.hide_source_outlined,
                            title: "Hide",
                            onTap: () => postWidget.onHide()),
                      if (actions.canReport)
                        ActionData(
                            icon: Icons.report,
                            title: "Report",
                            onTap: () async {
                              final reportController = TextEditingController();
                              if ((await launchTextConfirmationDialog(
                                          context,
                                          "What is wrong with this post?",
                                          reportController,
                                          "Write here") ??
                                      false) &&
                                  (await postService.reportItem(
                                          itemParameters:
                                              ItemParameters(id: post.id),
                                          reason: reportController.text) != null)) {
                                // ignore: use_build_context_synchronously
                                showSocialUtilSnackbar(
                                    context: context,
                                    message: "Post reported",
                                    type: DisplayMessageType.success);
                              }
                            }),
                      if (actions.canUpdate)
                        ActionData(
                            icon: Icons.edit,
                            title: "Edit",
                            onTap: () async {
                              Widget? creator;
                              if (post is SecondHand) {
                                creator = CreateSecondHand(
                                    controller:
                                        CreateSecondHandController.update(
                                            secondHand: post as SecondHand));
                              } else if (post is LostAndFound) {
                                creator = CreateLostAndFound(
                                    controller:
                                        CreateLostAndFoundController.update(
                                            lostAndFound:
                                                post as LostAndFound));
                              } else if (post is Donation) {
                                creator = CreateDonation(
                                    controller: CreateDonationController.update(
                                        donation: post as Donation));
                              } else if (post is Borrowable) {
                                creator = CreateBorrowable(
                                    controller:
                                        CreateBorrwableController.update(
                                            borrowable: post as Borrowable));
                              }

                              if (creator != null) launchPage(context, creator);
                            }),
                    ])
        ],
      ),
    );
  }
}
