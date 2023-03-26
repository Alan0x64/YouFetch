import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../screens/videoplayer.dart';
import '../util/uploaddatae.dart';
import 'goto.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key, required this.videos});
  final List<Video> videos;

  @override
  State<VideoList> createState() => VideoListState();
}

class VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.videos.length,
      itemBuilder: (context, index) {
        Video video = widget.videos[index];
        return InkWell(
          onTap: () {
             goto(
              context,
              VideoPlayer(video: video)
            );
          },
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 190,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(video.thumbnails.highResUrl.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 4,
                        child: Text(
                          video.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Expanded(
                        flex: 1,
                        child: Text(
                          video.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${video.engagement.viewCount.toString()} Views",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5.0),
                          const Text(
                            "|",
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            getTimeAgo(video.uploadDate!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
