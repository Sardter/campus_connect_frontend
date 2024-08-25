import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PostButtons extends StatefulWidget {
  const PostButtons(
      {super.key,
      required this.post,
      required this.reachToAuthorTitle,
      required this.reachToAuthorIcon,
      required this.isDetail,
      required this.postService});
  final Post post;
  final PostService postService;
  final String reachToAuthorTitle;
  final IconData reachToAuthorIcon;
  final bool isDetail;

  @override
  State<PostButtons> createState() => _PostButtonsState();
}

class _PostButtonsState extends State<PostButtons> {
  late bool _isFavorited = widget.post.isFavorited;
  late int _favoriteCount = widget.post.favoriteCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialUtilIconButton(
              title: widget.reachToAuthorTitle,
              icon: widget.reachToAuthorIcon,
              onTap: () async {
                final room = widget.post.author;

                launchPage(context, ChatPage(room: room));
              }),
          SocialUtilIconButton(
              title: "Comment",
              icon: Icons.comment_outlined,
              onTap: () async {
                if (!widget.isDetail) {
                  launchPage(
                      context,
                      PostDetailPage(
                        postService: widget.postService,
                        id: widget.post.id,
                      ));
                }
              }),
          SocialUtilIconButton(
              title: _favoriteCount.toString(),
              icon: _isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              color: _isFavorited ? ThemeService.clubColor : null,
              onTap: () async {
                if (await widget.postService.favorite(post: ItemParameters(id: widget.post.id)) != null) {
                  _isFavorited = !_isFavorited;
                  _isFavorited ? _favoriteCount++ : _favoriteCount--;
                }
                setState(() {});
              }),
        ],
      ),
    );
  }
}
