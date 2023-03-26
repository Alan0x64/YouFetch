// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youfetch/controllers/yt_downloader.dart';
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
                future: YTDownloader.getVideoInfo(txtcon.text),
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
                        await YTDownloader.getVideoInfo(txtcon.text);
                    widget.playlist =
                        await YTDownloader.getPlaylistInfo(txtcon.text);
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
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 173, 11, 11),
                      ),
                      child: const Text(
                        "Stop Downloads",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        YTDownloader.restartConnection();
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
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 73, 172),
                      ),
                      child: const Text(
                        "Set Donwload Location",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        YTDownloader.userVideosDic =
                            (await FilePicker.platform.getDirectoryPath())!;
                        AppConsole.log(YTDownloader.userVideosDic);
                      },
                    ),
                  ),
                ),
              ],
            ),
             const SizedBox(
                  height: 5,
                ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
                    height: 50,
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
                            await YTDownloader.getVideoInfo(txtcon.text);
                        widget.playlist =
                            await YTDownloader.getPlaylistInfo(txtcon.text);

                        if (widget.vid != null && widget.playlist == null) {
                          widget.vid =
                              await YTDownloader.download(context,txtcon.text);
                                 if (widget.vid!=null) {
                                    snackbar(context, "Video Downloaded!", 3);
                                  }
                        } else if (widget.playlist != null &&
                            widget.vid == null) {
                          snackbar(context, "Playlist Found!", 3);
                          widget.playlist =
                              await YTDownloader.downloadPlaylist(context,
                                  txtcon.text);
                                  if (widget.playlist!=null) {
                                    snackbar(context, "Videos Downloaded!", 3);
                                  }
                        } else {
                          snackbar(context, "Invaild Link!", 3);
                          return;
                        }
                        setState(() {});
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
