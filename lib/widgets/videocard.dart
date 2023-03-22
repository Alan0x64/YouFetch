// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class VideoCard extends StatefulWidget {

  final String title;
  final String thumb;


  const VideoCard({Key? key, required this.title, required this.thumb}) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

  @override
  void initState() {
    super.initState();

    // _thumbnailUrl = widget.vid.thumbnails.highResUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Image.network(
              width: 500,
              height: 500,
              widget.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
