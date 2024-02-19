import 'package:animo/models/content/video_data.dart';
import 'package:animo/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlayBackSpeedChanging = true,
    this.thumbnail,
    this.videoData,
  });

  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlayBackSpeedChanging;
  final String? thumbnail;
  final VideoData? videoData;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  ChewieController? _chewieController;
  VideoData? _videoData;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _updateVideoController();
  }

  void _updateVideoController() {
    final oldController = _chewieController;
    _videoData = widget.videoData;
    if (_videoData == null) {
      return;
    }

    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(_videoData!.sources[index].url))
        ..initialize().then((_) {
          setState(() {});
        }),
      looping: widget.looping,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlayBackSpeedChanging,
      showControls: widget.showControls,
      autoPlay: widget.autoPlay,
    );

    oldController?.videoPlayerController.dispose();
    oldController?.dispose();
  }

  @override
  void dispose() {
    super.dispose();

    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoData != widget.videoData) {
      _updateVideoController();
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _chewieController == null
            ? widget.thumbnail == null
                ? const Center(
                    child: Loader(),
                  )
                : CachedNetworkImage(
                    imageUrl: widget.thumbnail!,
                    fit: BoxFit.cover,
                  )
            : Chewie(controller: _chewieController!),
      ),
    );
  }
}
