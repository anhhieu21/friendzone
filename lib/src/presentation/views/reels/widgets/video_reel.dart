import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friendzone/src/domain/models/reel.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class VideoReel extends StatefulWidget {
  final Reel reel;
  const VideoReel({super.key, required this.reel});
  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  late VideoPlayerController _controller;
  late Timer timer;
  StreamController<bool> streamControllerShowBtnPlay =
      StreamController<bool>.broadcast();
  _playVideo() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.reel.link),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((value) {
        setState(() {
          _controller.play();
        });
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            setState(() {});
          }
        });
      });
    _showButtonPlay(false);
  }

  _showButtonPlay(bool value) {
    timer = Timer(const Duration(seconds: 3), () {
      streamControllerShowBtnPlay.sink.add(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: StreamBuilder<bool>(
            stream: streamControllerShowBtnPlay.stream,
            builder: (context, snapshot) {
              final isShow = snapshot.data ?? true;
              if (isShow) {
                _showButtonPlay(false);
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  // AspectRatio(
                  //   aspectRatio: 16 / 9,
                  //   child: VideoPlayer(_controller),
                  // ),
                  Positioned(
                    child: AnimatedOpacity(
                      opacity: isShow ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: IconButton.filledTonal(
                        onPressed: _playVideo,
                        icon: Icon(_controller.value.isPlaying
                            ? Ionicons.pause
                            : Ionicons.play),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: kBottomNavigationBarHeight,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(_controller,
                          allowScrubbing: true)),
                  Positioned.fill(
                      child: GestureDetector(
                    onTap: () => streamControllerShowBtnPlay.sink.add(!isShow),
                  ))
                ],
              );
            }));
  }
}
