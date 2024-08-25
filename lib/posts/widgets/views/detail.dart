import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, this.id, required this.postService});
  final dynamic id;
  final ModelService<Post> postService;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final _commentService = ServiceFactory.commentService;

  Post? _post;
  List<Comment> _commments = [];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: _post?.title ?? "",
      body: RefreshablePage(
        onRefresh: () async {
          _post = await widget.postService
              .getItem(itemParameters: ItemParameters(id: widget.id));

          if (_post == null) {
            // ignore: use_build_context_synchronously
            closePage(context);
            return null;
          }

          _commentService.reset();
          _commments = await _commentService.getList(
                  queryParameters:
                      CommentQueryParameters(searchQuery: null, post: _post)) ??
              [];

          setState(() {});

          return [
            PostWidget(
              post: _post!,
              isDetail: true,
            ),
            CreateCommentWidget(
              post: _post!,
              postService: widget.postService,
            ),
            // ignore: use_build_context_synchronously
            ...withDividers(_commments, context,
                (item, index) => CommentWidget(comment: item))
          ];
        },
        onLoad: () async {
          if (!_commentService.next()) return null;

          _commments += await _commentService.getList(
                  queryParameters:
                      CommentQueryParameters(searchQuery: null, post: _post)) ??
              [];

          setState(() {});

          return [
            PostWidget(
              post: _post!,
              isDetail: true,
            ),
            CreateCommentWidget(
              post: _post!,
              postService: widget.postService,
            ),
            // ignore: use_build_context_synchronously
            ...withDividers(_commments, context,
                (item, index) => CommentWidget(comment: item))
          ];
        },
      ),
    );
  }
}
