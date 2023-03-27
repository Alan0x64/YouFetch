import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_api/youtube_api.dart';

class Youtube {
  static int maxResults = 25;
  static final String _key = dotenv.get('YT_API_BROWSER');
  static YoutubeAPI api = YoutubeAPI(_key, maxResults: maxResults);
  static List<String> searchType = ['video', 'channel', 'playlist'];

  static Future<List<YouTubeVideo>> search(String query, int vidChList) async {
    return await api.search(query, type: searchType[vidChList]);
  }

 
}
