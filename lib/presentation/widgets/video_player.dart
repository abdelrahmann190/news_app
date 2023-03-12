// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWithChewie extends StatefulWidget {
  final String videoPlayerLink;
  const VideoPlayerWithChewie({
    Key? key,
    required this.videoPlayerLink,
  }) : super(key: key);

  @override
  State<VideoPlayerWithChewie> createState() => _VideoPlayerWithChewieState();
}

class _VideoPlayerWithChewieState extends State<VideoPlayerWithChewie> {
  ChewieController? chewieController;

  late VideoPlayerController videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return chewieController != null
        ? Chewie(controller: chewieController!)
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
  }

  void _initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.network(
      widget.videoPlayerLink,
    );
    await videoPlayerController.initialize();

    setState(() {
      chewieController = ChewieController(
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.black,
          bufferedColor: Colors.black12,
          handleColor: Colors.white,
        ),
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        autoPlay: true,
        looping: false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
