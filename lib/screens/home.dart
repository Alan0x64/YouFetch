// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:youfetch/controllers/donwloadvideo.dart';
import 'package:youfetch/util/appbar.dart';
import 'package:youfetch/util/console.dart';
import 'package:youfetch/util/searchvideos.dart';
import 'package:youfetch/widgets/homelist.dart';
import 'package:youfetch/widgets/search.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
   late Future<dynamic>? data;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoSearchList? vidd;

  @override
  void initState() {
    super.initState();
    widget.data = YoutuberDownload.yt.search('Xbox');
  }


  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: buildAppBar(
          context,
          "Home",
          search: true,
          searchWidget: Search(
            body: (query) => searchVideos(query),
          ),
        ),
        body: FutureBuilder(
          future:widget.data ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeList(videos: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    } catch (e) {
      AppConsole.log(e);
      return const Text("Somthing Went Wrong");
    }
  }
}
