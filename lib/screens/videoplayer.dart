import 'package:flutter/material.dart';
import 'package:youfetch/util/appbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.video});
  final Video video;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.video.id.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller!,
        showVideoProgressIndicator: true,
      ),
      builder: (p0, p1) {
        return Scaffold(
      appBar: buildAppBar(p0, widget.video.title),
      body: p1
    );
      },
    );
  }
}
