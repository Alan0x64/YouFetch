// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:youfetch/controllers/donwloadvideo.dart';
import 'package:youfetch/util/appbar.dart';
import 'package:youfetch/util/console.dart';
import 'package:youfetch/widgets/videocard.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../util/snackbar.dart';

class DownloadScreen extends StatefulWidget {
  DownloadScreen({Key? key}) : super(key: key);

  Video? vid;
  Playlist? playlist;

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  var txtcon = TextEditingController();
  final _futureBuilderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    txtcon.text = "https://youtu.be/fOoSbUoayQE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        "Download Videos-Playlists",
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: FutureBuilder(
                key: _futureBuilderKey,
                future: YoutuberDownload.getVideoInfo(txtcon.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: VideoCard(
                        thumb: snapshot.data!.thumbnails.highResUrl,
                        title: snapshot.data!.title,
                        // vid: snapshot.data!,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                enableInteractiveSelection: true,
                controller: txtcon,
                onChanged: (value) async {
                  try {
                    widget.vid =
                        await YoutuberDownload.getVideoInfo(txtcon.text);
                    widget.playlist =
                        await YoutuberDownload.getPlaylistInfo(txtcon.text);
                    _futureBuilderKey.currentState!.reassemble();
                    setState(() {});
                  } catch (e) {
                    AppConsole.log(e);
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Paste YouTube video or playlist link here',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 223, 14, 14),
                      ),
                      child: const Text(
                        "Stop Downloads",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        YoutuberDownload.restartConnection();
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 5, 134, 26),
                      ),
                      child: const Text(
                        "Download Video Or Playlist",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        widget.vid =
                            await YoutuberDownload.getVideoInfo(txtcon.text);
                        widget.playlist =
                            await YoutuberDownload.getPlaylistInfo(txtcon.text);

                        if (widget.vid != null && widget.playlist == null) {
                          widget.vid = await YoutuberDownload.downloadFromURL(
                              txtcon.text);
                          snackbar(context, "Video Downloaded!", 2);
                        } else if (widget.playlist != null &&
                            widget.vid == null) {
                          snackbar(context, "Playlist Found!", 3);
                          widget.playlist =
                              await YoutuberDownload.downloadPlaylist(
                                  txtcon.text);
                          snackbar(context, "Videos Downloaded!", 3);
                        } else {
                          snackbar(context, "Invaild Link!", 3);
                          return;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
