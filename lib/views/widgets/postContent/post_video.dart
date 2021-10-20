import 'package:flapp/views/loading.dart';

import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoWidget extends StatefulWidget {
  final Post post;
  const PostVideoWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostVideoWidget> createState() => _PostVideoWidgetState();
}

class _PostVideoWidgetState extends State<PostVideoWidget>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.post.submission.url.toString() + "/DASH_720.mp4");

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width - 40;
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              onDoubleTap: () {},
              child: Hero(
                  tag: 'video-by-' + widget.post.title,
                  child: Container(
                      width: width,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true)
                      ]))),
            ));
          } else {
            return LoadingWidget();
          }
        });
  }
}
