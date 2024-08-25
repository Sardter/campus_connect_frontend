import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/users/widgets/widgets.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.comment});
  final Comment comment;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final _isHidden = ValueNotifier<bool>(false);

  late bool _isFavorited = widget.comment.isFavorited;
  late int _favoriteCount = widget.comment.favoriteCount;

  Future<bool> onHide() async {
    _isHidden.value = await ServiceFactory.commentService
            .hideItem(itemParameters: ItemParameters(id: widget.comment.id)) ??
        false;
    setState(() {});
    return _isHidden.value;
  }

  @override
  Widget build(BuildContext context) {
    return Hiddeble(
      onHide: onHide,
      isHidden: _isHidden,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getResponsiveMarginWidth(context), vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                launchPage(context, ProfilePage(id: widget.comment.author.id));
              },
              child: Column(
                children: [
                  SocialUtilImageProvider(
                      image: widget.comment.author.profilePhoto,
                      defaultImage: null),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 70,
                    child: Text(
                      widget.comment.author.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ThemeService.secondaryText, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(widget.comment.content)),
            const Spacer(),
            Column(
              children: [
                IconButton(
                    onPressed: () async {
                      if (await ServiceFactory.commentService.favorite(
                              itemParameters:
                                  ItemParameters(id: widget.comment.id)) != false) {
                        _isFavorited = !_isFavorited;
                        _isFavorited ? _favoriteCount++ : _favoriteCount--;
                      }

                      setState(() {});
                    },
                    icon: Icon(
                      _isFavorited
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: _isFavorited ? ThemeService.clubColor : null,
                    )),
                const SizedBox(height: 5),
                Text(_favoriteCount.toString(),
                    style: TextStyle(
                      color: _isFavorited ? ThemeService.clubColor : null,
                    )),
                if (widget.comment.allowedActions != null)
                  AllowedActionsWidget<AllowedActions, Comment>(
                      actions: widget.comment.allowedActions!,
                      modelService: ServiceFactory.commentService,
                      model: widget.comment,
                      size: 15,
                      actionMapper: (actions, context) => [
                            if (actions.canDelete)
                              ActionData(
                                  icon: Icons.delete,
                                  title: "Delete",
                                  onTap: () async {
                                    if ((await launchConfirmationDialog(context,
                                                "Do you really want to delete this comment?") ??
                                            false) &&
                                        (await ServiceFactory.commentService
                                                .deleteItem(
                                                    itemParameters:
                                                        ItemParameters(
                                                            id: widget
                                                                .comment.id)) != null)) {
                                      // ignore: use_build_context_synchronously
                                      showSocialUtilSnackbar(
                                          context: context,
                                          message: "Comment deleted",
                                          type: DisplayMessageType.success);
                                    }
                                  }),
                            if (actions.canHide)
                              ActionData(
                                  icon: Icons.hide_source_outlined,
                                  title: "Hide",
                                  onTap: () => onHide()),
                            if (actions.canReport)
                              ActionData(
                                  icon: Icons.report,
                                  title: "Report",
                                  onTap: () async {
                                    final reportController =
                                        TextEditingController();
                                    if ((await launchTextConfirmationDialog(
                                                context,
                                                "What is wrong with this comment?",
                                                reportController,
                                                "Write here") ??
                                            false) &&
                                        (await ServiceFactory.commentService
                                                .reportItem(
                                                    itemParameters:
                                                        ItemParameters(
                                                            id: widget
                                                                .comment.id),
                                                    reason: reportController
                                                        .text) ??
                                            false)) {
                                      // ignore: use_build_context_synchronously
                                      showSocialUtilSnackbar(
                                          context: context,
                                          message: "Comment reported",
                                          type: DisplayMessageType.success);
                                    }
                                  }),
                          ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
