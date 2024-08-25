import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/second_hands/models/models.dart';
import 'package:campus_connect_frontend/second_hands/widgets/components/components.dart';
import 'package:campus_connect_frontend/users/widgets/components/user_header.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/widgets.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post, this.isDetail = false});
  final bool isDetail;
  final Post post;

  @override
  State<PostWidget> createState() => PostWidgetState();
}

class PostWidgetState extends State<PostWidget> {
  final isHidden = ValueNotifier<bool>(false);

  ModelService<Post> get _getDetailService {
    if (widget.post is SecondHand) {
      return ServiceFactory.secondHandService;
    } else if (widget.post is Borrowable) {
      return ServiceFactory.borrowableService;
    } else if (widget.post is Donation) {
      return ServiceFactory.donationService;
    } else if (widget.post is LostAndFound) {
      return ServiceFactory.lostAndFoundService;
    }

    throw UnimplementedError();
  }

  Widget _buildPost() {
    if (widget.post is SecondHand) {
      return SecondHandWidget(
          secondHand: widget.post as SecondHand, isDetail: widget.isDetail);
    } else if (widget.post is Borrowable) {
      return BorrowableWidget(
          borrowable: widget.post as Borrowable, isDetail: widget.isDetail);
    } else if (widget.post is Donation) {
      return DonationWidget(
          donation: widget.post as Donation, isDetail: widget.isDetail);
    } else if (widget.post is LostAndFound) {
      return LostAndFoundWidget(
          lostAndFound: widget.post as LostAndFound, isDetail: widget.isDetail);
    }

    throw UnimplementedError();
  }

  Future<bool> onHide() async {
    isHidden.value = await _getDetailService.hideItem(
            itemParameters: ItemParameters(id: widget.post.id)) != null;
    setState(() {});
    return isHidden.value;
  }

  @override
  Widget build(BuildContext context) {
    return Hiddeble(
        onHide: onHide,
        isHidden: isHidden,
        child: GestureDetector(
          onTap: widget.isDetail
              ? null
              : () async {
                  launchPage(
                      context,
                      PostDetailPage(
                        postService: _getDetailService,
                        id: widget.post.id,
                      ));
                },
          child: SocialUtilCard(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
                vertical: 5, horizontal: getResponsiveMarginWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserHeaderWidget(
                    post: widget.post,
                    postService: _getDetailService,
                    postWidget: this),
                const SizedBox(height: 10),
                Text(
                  widget.post.title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                if (widget.post.media.isNotEmpty) ...[
                  SocialUtilMediaCarousal(media: widget.post.media),
                  const SizedBox(height: 10),
                ],
                Text(widget.post.description),
                _buildPost()
              ],
            ),
          ),
        ));
  }
}
