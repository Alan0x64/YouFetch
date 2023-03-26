import 'package:flutter/material.dart';
import 'package:youfetch/models/channel.dart';
import 'package:youfetch/screens/videoplayer.dart';
import 'package:youfetch/util/uploaddatae.dart';
import 'package:youfetch/widgets/goto.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeList2 extends StatefulWidget {
  HomeList2({
    super.key,
    required this.videos,
    required this.channels,
  });
  late final List<dynamic> videos;
  late final List<dynamic> channels;

  @override
  State<HomeList2> createState() => _HomeList2State();
}

class _HomeList2State extends State<HomeList2> {
  @override
  Widget build(BuildContext context) {
    var videos = widget.videos;
    var channels = widget.channels;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        YouTubeVideo video = videos[index];
        YoutubeChannel channel = channels[index];

        return InkWell(
          onTap: () {
            // goto(context, VideoPlayer(video: video));
            // goto(context, YTWebView(url: video.url,));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(video.thumbnail.high.url.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(channel.thumbnails.high.url.toString()),
                    ),
                  ),
                ),
                title: Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    "${video.channelTitle} | ${getTimeAgo(DateTime.parse(video.publishedAt!))}",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

   // Container(
              //   margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
              //   child: CircleAvatar(
              //     radius: 20, // size of the circle
              //     backgroundImage:
              //         NetworkImage(""), // image source
              //   ),
              // ),
 // Container(
              //   margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         video.title,
              //           maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //         style: const TextStyle(
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(height: 10.0),
              //       Row(
              //         children: [
              //           Text(
              //             video.channelTitle,
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //           const SizedBox(width: 5.0),
              //           const Text(
              //             "|",
              //           ),
              //           const SizedBox(width: 5.0),
              //           Text(
              //             "${video.id.toString()} Views",
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //           const SizedBox(width: 5.0),
              //           const Text(
              //             "|",
              //           ),
              //           const SizedBox(width: 5.0),
              //           Text(
              //             getTimeAgo(DateTime.parse(video.publishedAt!)),
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),