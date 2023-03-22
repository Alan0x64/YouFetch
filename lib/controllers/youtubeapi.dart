import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeAPI {
  static var yt = YoutubeExplode();

  static Future<List<Video>>  search(String query) async {
    return await yt.search(query);
  }
}
