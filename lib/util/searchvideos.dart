import 'package:flutter/material.dart';
import 'package:youfetch/controllers/youtubeapi.dart';

import '../widgets/videolist.dart';

Widget searchVideos(String query) {
  return FutureBuilder(
                future: YoutubeAPI.search(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return VideoList(videos: snapshot.data!);
                  }else{
                  return const Center(child: CircularProgressIndicator(),);
                  }
                },
              );
}