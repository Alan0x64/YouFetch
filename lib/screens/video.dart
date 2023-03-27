import 'package:flutter/material.dart';
import 'package:youfetch/controllers/explode.dart';
import 'package:youfetch/widgets/future_builder.dart';
import 'package:youfetch/widgets/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.vid});
  final Video vid;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final Future<String> streamURL;


  @override
  void initState() {
    super.initState();
    streamURL = YTExplode.getStreamURL(widget.vid.id);
  }

  @override
  Widget build(BuildContext context) {
    return BuildFuture(
      callback: () async {
         return await streamURL;

      },
      builder: (data) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                CrossPlatFormVideoPlayer(url:  data),
              ],
            ),
          ),
        );
      },
    );
  }
}
