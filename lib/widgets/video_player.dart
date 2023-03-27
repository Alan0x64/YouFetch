import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

class CrossPlatFormVideoPlayer extends StatefulWidget {
  const CrossPlatFormVideoPlayer({super.key, required this.url});
  final String url;

  @override
  State<CrossPlatFormVideoPlayer> createState() =>
      CrossPlatFormVideoPlayerState();
}

class CrossPlatFormVideoPlayerState extends State<CrossPlatFormVideoPlayer> {
  late MeeduPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MeeduPlayerController(
      loadingWidget: const CircularProgressIndicator(),
      enabledButtons: const EnabledButtons(
        muteAndSound: false,
        videoFit: false
      ),
      controlsStyle: ControlsStyle.secondary);
    setSource();
  }

  void setSource() async {
    await _controller.setDataSource(
      DataSource(
        source: widget.url,
        type: DataSourceType.network,
      ),
      autoplay: true,
    );
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: MeeduVideoPlayer(
            controller: _controller,)
        ),
      );
  }
}