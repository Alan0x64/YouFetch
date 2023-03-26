import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CrossVideoPlayer extends StatefulWidget {
  const CrossVideoPlayer({super.key, required this.url});
  final String url;

  @override
  State<CrossVideoPlayer> createState() => CrossVideoPlayerState();
}

class CrossVideoPlayerState extends State<CrossVideoPlayer> {
 // Create a [Player] instance from `package:media_kit`.
  final Player player = Player();
  // Reference to the [VideoController] instance from `package:media_kit_video`.
  VideoController? controller;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // Create a [VideoController] instance from `package:media_kit_video`.
      // Pass the [handle] of the [Player] from `package:media_kit` to the [VideoController] constructor.
      controller = await VideoController.create(player.handle);
      // Must be created before opening any media. Otherwise, a separate window will be created.
      setState(() {});
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {
      // Release allocated resources back to the system.
      await controller?.dispose();
      await player.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Video(
      /// Pass the [controller] to display the video output.
      controller: controller,
    );
  }
}

