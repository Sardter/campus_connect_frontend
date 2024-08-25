// ignore_for_file: use_build_context_synchronously

import 'package:campus_connect_frontend/comments/models/comment.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CreateCommentWidget extends StatefulWidget {
  const CreateCommentWidget(
      {super.key, required this.post, required this.postService});
  final Post post;
  final ModelService<Post> postService;

  @override
  State<CreateCommentWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<CreateCommentWidget> {
  final _commentService = ServiceFactory.commentService;
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SocialUtilCard(
        margin: EdgeInsets.symmetric(
            horizontal: getResponsiveMarginWidth(context), vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
                type: TextInputType.text,
                onChanged: (value) => setState(() {}),
                controller: _contentController,
                hint: "Leave a Comment"),
            if (_contentController.text.isNotEmpty) ...[
              const SizedBox(height: 10),
              SocialUtilButton(
                  children: const [Text('Publish')],
                  onTap: () async {
                    final comment = await _commentService.postItem(
                        item: Comment(
                            id: -1,
                            author: const User(id: -1, email: ""),
                            content: _contentController.text,
                            postId: widget.post.id,
                            allowedActions: null,
                            createdAt: DateTime.now()));
                    if (comment != null) _contentController.clear();
                    closePage(context);
                    launchPage(
                        context,
                        PostDetailPage(
                          postService: widget.postService,
                          id: widget.post.id,
                        ));

                    setState(() {});

                    showSocialUtilSnackbar(
                        context: context,
                        message: comment == null
                            ? "Comment could not be published"
                            : "Comment Published",
                        type: comment == null
                            ? DisplayMessageType.danger
                            : DisplayMessageType.success);

                    return false;
                  })
            ]
          ],
        ));
  }
}
