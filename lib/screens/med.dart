import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

class CrossVideoPlayer extends StatefulWidget {
  const CrossVideoPlayer({super.key, required this.url});
  final String url;

  @override
  State<CrossVideoPlayer> createState() => CrossVideoPlayerState();
}

class CrossVideoPlayerState extends State<CrossVideoPlayer> {
  // final _meeduPlayerController = MeeduPlayerController();
  late MeeduPlayerController _controller;

  final ValueNotifier<bool> _subtitlesEnabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _controller = MeeduPlayerController(
      controlsStyle: ControlsStyle.primary,
    );
    _setDataSource();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _setDataSource() async {
    await _controller.setDataSource(
      DataSource(
        source:
            'https://thepaciellogroup.github.io/AT-browser-tests/video/ElephantsDream.mp4',
        type: DataSourceType.network,
      ),
      autoplay: true,
    );
    _controller.onClosedCaptionEnabled(true);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: MeeduVideoPlayer(
            controller: _controller,
            bottomRight: (ctx, controller, responsive) {
              // creates a responsive fontSize using the size of video container
              final double fontSize = responsive.ip(3);

              return CupertinoButton(
                padding: const EdgeInsets.all(5),
                minSize: 25,
                child: ValueListenableBuilder(
                  valueListenable: _subtitlesEnabled,
                  builder: (BuildContext context, bool enabled, _) {
                    return Text(
                      "CC",
                      style: TextStyle(
                        fontSize: fontSize > 18 ? 18 : fontSize,
                        color: Colors.white.withOpacity(
                          enabled ? 1 : 0.4,
                        ),
                      ),
                    );
                  },
                ),
                onPressed: () {
                  _subtitlesEnabled.value = !_subtitlesEnabled.value;
                  _controller.onClosedCaptionEnabled(_subtitlesEnabled.value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
