import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class VideoReel extends StatefulWidget {
  const VideoReel({super.key});

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  late VideoPlayerController _controller;
  _playVideo() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/banahillroad2.mp4')
      ..initialize().then((value) {
        setState(() {
          _controller.play();
        });
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            setState(() {});
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          top: kToolbarHeight * 0.7,
          bottom: kBottomNavigationBarHeight,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        Positioned(
          child: IconButton.filledTonal(
            onPressed: _playVideo,
            icon: Icon(
                _controller.value.isPlaying ? Ionicons.pause : Ionicons.play),
          ),
        ),
        Positioned(
            bottom: kBottomNavigationBarHeight,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(_controller, allowScrubbing: true))
      ],
    ));
  }
}
