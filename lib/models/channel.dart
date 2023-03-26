import 'package:youfetch/controllers/youtubeapi.dart';
import 'package:youtube_api/src/model/thumbnails.dart';
import 'package:youtube_api/youtube_api.dart';

class YoutubeChannel {
  String id;
  String title;
  String description;
  DateTime publishedAt;
  String url;
  Thumbnails thumbnails;

  YoutubeChannel({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.url,
    required this.thumbnails,
  });

  static YoutubeChannel fromYTVID(YouTubeVideo res) {
    return YoutubeChannel(
        title: res.title,
        id: res.channelId ?? "0",
        description: res.description ?? "No Channel Description",
        url: res.channelUrl ?? "No Channel URL",
        publishedAt: res.publishedAt != null
            ? DateTime.parse(res.publishedAt!)
            : DateTime.now(),
        thumbnails: res.thumbnail);
  }

  static Future<List<YoutubeChannel>> search(query) async {
    List<YoutubeChannel> list = [];

    for (var element in await Youtube.search(query, 1)) {
      list.add(fromYTVID(element));
    }

    return list;
  }

  static Future<List<YoutubeChannel>> getVideosChannels(
      List<dynamic> vids) async {
    Youtube.maxResults = 5;
    List<YoutubeChannel> list = [];
    List<YoutubeChannel> data;

    for (var i = 0; i < vids.length; i++) {
      data = await YoutubeChannel.search(vids[i].channelTitle);

      if (data[i].title == vids[i].channelTitle) {
        list.add(data[i]);
      }
    }

    return list;
  }
}
