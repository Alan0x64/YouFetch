
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youfetch/util/uploaddatae.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class HomeList extends StatefulWidget {
  const HomeList({super.key, required this.videos});
  final List<Video> videos;

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.videos.length,
      itemBuilder: (context, index) {
        Video video = widget.videos[index];
        return InkWell(
          onTap: () {
            launchUrlString(video.url);
            // goto(
            //   context,
            //   ViodePlayer(video: video)
            // );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(video.thumbnails.highResUrl.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          video.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 5.0),
                        const Text(
                          "|",
                        ),
                        const SizedBox(width: 5.0),
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
        );
      },
    );
  }
}
