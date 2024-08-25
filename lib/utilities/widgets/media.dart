import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SocialUtilMediaCarousal extends StatefulWidget {
  const SocialUtilMediaCarousal({Key? key, required this.media}) : super(key: key);
  final List<MediaData> media;

  @override
  State<SocialUtilMediaCarousal> createState() => SocialUtilMediaCarousalState();
}

class SocialUtilMediaCarousalState extends State<SocialUtilMediaCarousal> {
  int _current = 0;
  bool _indicatorVisible = true;
  final _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _indicatorVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
            carouselController: _controller,
            items: widget.media
                .map<Widget>((mediaItem) => SizedBox(
                      width: double.maxFinite,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: mediaItem is ImageData
                            ? MediaImage(imageData: mediaItem)
                            : MediaVideo(
                                videoData: mediaItem as VideoData),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 1,
                padEnds: false,
                clipBehavior: Clip.none,
                onPageChanged: (index, reason) {
                  setState(() {
                    _indicatorVisible = true;
                    _current = index;
                  });

                  Future.delayed(const Duration(seconds: 3), () {
                    if (mounted) {
                      setState(() {
                        _indicatorVisible = false;
                      });
                    }
                  });
                },
                enableInfiniteScroll: false)),
        if (_indicatorVisible) ...[
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostMediaIndicator(widget: widget, current: _current),
            ),
          ),
          Positioned(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => _controller.previousPage(),
                    icon: const Icon(Icons.keyboard_arrow_left),
                    iconSize: 30,
                    color: Colors.white60,
                  ))),
          Positioned(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => _controller.nextPage(),
                    icon: const Icon(Icons.keyboard_arrow_right),
                    iconSize: 30,
                    color: Colors.white60,
                  ))),
        ]
      ],
    );
  }
}

class PostMediaIndicator extends StatelessWidget {
  const PostMediaIndicator({
    super.key,
    required this.widget,
    required int current,
  }) : _current = current;

  final SocialUtilMediaCarousal widget;
  final int _current;

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            width: 1,
          ),
          ...widget.media.map<Widget>((e) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  color: count++ == _current ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(100)),
              height: 5,
              width: 5,
            );
          }).toList(),
          const SizedBox(
            width: 1,
          )
        ],
      ),
    );
  }
}
