// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:youfetch/util/snackbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../util/console.dart';

class YTDownloader {
  static var yt = YoutubeExplode();
  static String userVideosDic = "";
  static const String defaultDirName = "Random";
  static const String defaultAppDirName = "YouFetch";

  static String getcode(String url) {
    return url.split('/').last.toString();
  }

  static String? makePath(BuildContext context, String file,
      {String folder = defaultDirName, int getDir = 0}) {
    folder = folder.isEmpty ? defaultDirName : folder;

    file = sanitizeFilename(file);
    folder = sanitizeFilename(folder);

    if (userVideosDic.isEmpty) {
      snackbar(context, "Choose Where To Download First", 3);
      return null;
    }

    if (getDir == 1) {
      return "$userVideosDic/$defaultAppDirName/$folder";
    }

    return "$userVideosDic/$defaultAppDirName/$folder/$file.mp4";
  }

  static Future<Directory?> createDirectory(BuildContext context,
      {String dirName = defaultDirName}) async {
    dirName = dirName.isEmpty ? defaultDirName : dirName;

    var p = makePath(context, '', folder: dirName, getDir: 1);
    if (p == null) return null;

    return await Directory(p).create(recursive: true);
  }

  static void restartConnection() async {
    yt.close();
    await Future.delayed(const Duration(seconds: 3));
    yt = YoutubeExplode();
  }

  static Future<Video?> getVideoInfo(String url) async {
    try {
      return await yt.videos.get(url);
    } catch (e) {
      return null;
    }
  }

  static Future<Playlist?> getPlaylistInfo(String url) async {
    try {
      return await yt.playlists.get(url);
    } catch (e) {
      return null;
    }
  }

  static String sanitizeFilename(String name) {
    const invalidChars = r'\/:*?"<>|\' '';
    var invalidRegEx = '[${RegExp.escape(invalidChars)}]';
    const invalidQuotesRegEx = r'''['"]''';
    return name
        .replaceAll(RegExp(invalidRegEx), '')
        .replaceAll(RegExp(invalidQuotesRegEx), '');
  }

  static Future<bool> writeToFile(
    String path,
    Stream<List<int>> stream,
  ) async {
    await File(path).create();
    var fileStream = File(path).openWrite();
    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();
    return true;
  }

  static Future<Video?> download(BuildContext context, String url,
      {String dirName = ""}) async {
    try {
      var video = await getVideoInfo(url);
      var manifest = await yt.videos.streamsClient.getManifest(getcode(url));
      MuxedStreamInfo? streamInfo = manifest.muxed.bestQuality;

      var p = makePath(context, video!.title, folder: dirName);
      if (p == null) return null;

      await createDirectory(context, dirName: dirName);

      var res = await writeToFile(
        p,
        yt.videos.streamsClient.get(streamInfo),
      );

      if (res == true) {
        return video;
      }
    } catch (e) {
      AppConsole.log(e);
      return null;
    }
    return null;
  }

  static Future<Playlist?> downloadPlaylist(
      BuildContext context, String playlistUrl) async {
    try {
      var playlist = await getPlaylistInfo(playlistUrl);
      await for (Video video in yt.playlists.getVideos(playlist!.id)) {
        var result = await download(context, video.id.toString(),
            dirName: playlist.title);
        if (result == null) return null;
      }
      return playlist;
    } catch (e) {
      AppConsole.log(e);
      return null;
    }
  }
}
