// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:youfetch/controllers/explode.dart';
import 'package:youfetch/util/appbar.dart';
import 'package:youfetch/util/console.dart';
import 'package:youfetch/util/searchvideos.dart';
import 'package:youfetch/widgets/future_builder.dart';
import 'package:youfetch/widgets/homelist.dart';
import 'package:youfetch/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> vidoes;
  late List<dynamic> channles;

  late Future<List<dynamic>?> channless;

  @override
  void initState() {
    super.initState();

    vidoes = YTExplode.search("Xbox");
    channless = YTExplode.getVideoChannels(vidoes);
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
          body: BuildFuture(
            callback: () async {
              channles=(await channless)!;
              return vidoes;
            },
            builder: (data) {
              return HomeList(
                videos: data,
                channels: channles
              );
            },
          ));
    } catch (e) {
      AppConsole.log(e);
      return const Text("Something Went Wrong");
    }
  }
}
