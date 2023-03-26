import 'package:flutter/material.dart';
import 'package:youfetch/controllers/youtubeapi.dart';
import 'package:youtube_api/youtube_api.dart';

import '../controllers/explode.dart';
import '../widgets/videolist.dart';

Widget searchVideos(String query) {
  return FutureBuilder(
                future: YTExplode.search(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return VideoList(videos: snapshot.data!);
                  }else{
                  return const Center(child: CircularProgressIndicator(),);
                  }
                },
              );
}