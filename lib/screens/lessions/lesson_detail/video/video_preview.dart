import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../widgets/loading.dart';

class VideoPreviewScreen extends StatefulWidget {
  final bool isYouTube;
  final String url;
  const VideoPreviewScreen({
    required this.isYouTube,
    required this.url,
  });
  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  YoutubePlayerController? _controller;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    if (widget.isYouTube) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
    } else {
      videoPlayerController = VideoPlayerController.network(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: widget.isYouTube
            ? Center(
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
              )
            : FutureBuilder(
                future: videoPlayerController!.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingWidgets.getNormalLoading(),
                    );
                  }
                  chewieController = ChewieController(
                    videoPlayerController: videoPlayerController!,
                    autoPlay: true,
                    looping: true,
                  );
                  return Chewie(
                    controller: chewieController!,
                  );
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.isYouTube) {
      _controller!.dispose();
    } else {
      videoPlayerController!.dispose();
      chewieController!.dispose();
    }
    super.dispose();
  }
}
