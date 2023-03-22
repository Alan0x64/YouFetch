
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title,
    {bool showdialog = true,
    Widget? button,
    bool search = false,
    SearchDelegate? searchWidget}) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(title),
    leading: button,
    elevation: 0,
    actions: [
      if (search)
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: searchWidget!);
            },
            icon: const Icon(Icons.search)),
      // IconButton(
      //   icon: const Icon(CupertinoIcons.moon_stars),
      //   onPressed: () {
      //     try {
      //       if (showdialog) {
      //         showDialog(
      //             context: context,
      //             builder: (context) => CustomDialog(
      //                   bigText: "Sure Wanna Change Theme?",
      //                   smallerText: "All Unsaved Chnages Will Be Lost!",
      //                   quit: false,
      //                   fun: () async {
      //                     // ThemeProvider.controllerOf(context).nextTheme();
      //                     // Navigator.pop(context);
      //                     // return await Future.value(Response());
      //                   },
      //                 ));
      //       } else {
      //         // ThemeProvider.controllerOf(context).nextTheme();
      //       }
      //     } catch (e) {
      //       AppConsole.log(e);
      //     }
      //   },
      // )
    ],
  );
}