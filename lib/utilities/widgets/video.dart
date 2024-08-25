import 'package:campus_connect_frontend/utilities/utilities.dart';
//import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
//import 'package:line_icons/line_icons.dart';
//import 'package:visibility_detector/visibility_detector.dart';

class MediaVideo extends StatefulWidget {
  final VideoData videoData;
  const MediaVideo({Key? key, required this.videoData}) : super(key: key);

  @override
  State<MediaVideo> createState() => _MediaVideoState();
}

class _MediaVideoState extends State<MediaVideo> {
  //BetterPlayerController? controller;
  bool canChange = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //if (controller != null) controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return const Placeholder(); /* VisibilityDetector(
      key: widget.key!,
      onVisibilityChanged: (info) async {
        if (!mounted || !canChange) return;

        if (info.visibleFraction > 0.5) {
          if (controller == null) canChange = false;
          Future.delayed(Duration(seconds: 5), () {
            if (mounted)
              setState(() {
                canChange = true;
              });
          });
          controller = BetterPlayerController(
            BetterPlayerConfiguration(
              looping: true,
              aspectRatio: 1,
              fit: BoxFit.cover,
              controlsConfiguration: BetterPlayerControlsConfiguration(
                  playerTheme: BetterPlayerTheme.cupertino,
                  enableFullscreen: false,
                  enableQualities: false,
                  enableAudioTracks: false,
                  enableOverflowMenu: false,
                  showControlsOnInitialize: true,
                  controlBarColor:
                      ThemeService.eventColor.withOpacity(0.8),
                  playIcon: LineIcons.play,
                  enablePip: false,
                  enableSkips: false,
                  controlsHideTime: Duration(milliseconds: 50),
                  enableSubtitles: false,
                  enablePlaybackSpeed: false),
            ),
            betterPlayerDataSource: widget.videoData is NetworkVideoData
                ? BetterPlayerDataSource.network(
                    (widget.videoData as NetworkVideoData).url,
                    cacheConfiguration:
                        BetterPlayerCacheConfiguration(useCache: true),
                  )
                : BetterPlayerDataSource.file(
                    (widget.videoData as VideoFileData).file.path,
                    cacheConfiguration:
                        BetterPlayerCacheConfiguration(useCache: true)),
          );
          setState(() {});
        } else {
          if (controller == null) return;
          setState(() {
            canChange = false;
            Future.delayed(Duration(seconds: 5), () {
              if (mounted)
                setState(() {
                  canChange = true;
                });
            });
            controller = null;
          });
        }
      },
      child: Container(
          child: controller == null
              ? AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: LoadingIndicator(),
                  ),
                )
              : BetterPlayer(
                  controller: controller!,
                )),
    ); */
  }
}
