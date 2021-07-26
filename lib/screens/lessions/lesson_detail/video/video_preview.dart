import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/models/video_model.dart';
import 'package:teachers_app/screens/home/home_screen.dart';
import 'package:video_player/video_player.dart';
import '../../../../widgets/loading.dart';

class VideoPreviewScreen extends StatefulWidget {
  final List<VideoModel> videos;
  const VideoPreviewScreen({required this.videos});
  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videos[0].url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          return true;
        },
        child: SafeArea(
          child: FutureBuilder(
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
                additionalOptions: (context) {
                  return <OptionItem>[
                    if (widget.videos.length > 1)
                      OptionItem(
                        onTap: () {
                          Navigator.pop(context);

                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                child: Center(
                                  child: ListView(
                                    children: widget.videos
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    videoPlayerController =
                                                        VideoPlayerController
                                                            .network(e.url);
                                                  });
                                                },
                                                child: Text(
                                                  e.quality,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                          );
                          //   setState(() {});
                        },
                        iconData: Icons.video_collection_outlined,
                        title: 'video quality',
                      ),
                  ];
                },
              );
              return Chewie(
                controller: chewieController!,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();

    super.dispose();
  }
}
