import 'package:flutter/material.dart';
import 'package:youfetch/util/appbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViodePlayer extends StatefulWidget {
  const ViodePlayer({super.key, required this.video});
  final Video video;

  @override
  State<ViodePlayer> createState() => _ViodePlayerState();
}

class _ViodePlayerState extends State<ViodePlayer> {
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
    return Scaffold(
      appBar: buildAppBar(context, widget.video.title),
      body: YoutubePlayer(
          onReady :() {
          controller?.addListener(() {
        setState(() {
    
        });
          },);
      },
          controller: controller!, showVideoProgressIndicator: true),
    );
  }
}
