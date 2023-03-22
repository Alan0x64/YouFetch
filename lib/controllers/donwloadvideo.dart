import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../util/console.dart';

class YoutuberDownload {
  static var yt = YoutubeExplode();
  static const String defaultDic = './YouFetch';
  static const String defaultVideosDic = './YouFetch/Random';

  static String getcode(String url) {
    return url.split('/').last.toString();
  }

  static Future<Directory> createDirectory(
      {String dicName = defaultVideosDic}) async {
    return await Directory(dicName).create(recursive: true);
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

  static String removeSensitiveCharacters(String fileName) {
    final pattern = RegExp(r'[<>:"/\\|?*]');
    return fileName.replaceAll(pattern, '');
  }

  static String sanitizeFilename(String name) {
    const invalidChars = r'\/:*?"<>|\' '';
    var invalidRegEx = '[${RegExp.escape(invalidChars)}]';
    const invalidQuotesRegEx = r'''['"]''';
    return name
        .replaceAll(RegExp(invalidRegEx), '')
        .replaceAll(RegExp(invalidQuotesRegEx), '');
  }

  static Future<bool> writeToFile(String filename, Stream<List<int>> stream,
      {String dic = defaultVideosDic}) async {
    dic = dic.isEmpty ? defaultVideosDic : dic;
    await File("$dic/$filename.mp4").create();
    var fileStream = File("$dic/$filename.mp4").openWrite();
    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();
    return true;
  }

  static Future<Video?> downloadFromURL(String url, {String dic = ""}) async {
    try {
      var video = await getVideoInfo(url);
      var manifest = await yt.videos.streamsClient.getManifest(getcode(url));
      MuxedStreamInfo? streamInfo = manifest.muxed.bestQuality;

      await createDirectory();
      var res= await writeToFile(sanitizeFilename(video!.title),
          yt.videos.streamsClient.get(streamInfo),
          dic: dic);
          if (res==true) {
            return video;
          }
    } catch (e) {
      AppConsole.log(e);
      return null;
    }
    return null;
  }

  static Future<Playlist?> downloadPlaylist(String playlistUrl) async {
    try {
      var playlist = await getPlaylistInfo(playlistUrl);

      await createDirectory(
          dicName: "$defaultDic/${sanitizeFilename(playlist!.title)}");
      await for (Video video in yt.playlists.getVideos(playlist.id)) {
        await downloadFromURL(video.id.toString(),
            dic: "$defaultDic/${playlist.title}");
      }
      return playlist;
    } catch (e) {
      AppConsole.log(e);
      return null;
    }
  }
}
