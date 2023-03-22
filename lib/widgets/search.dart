
import 'package:flutter/material.dart';



class Search extends SearchDelegate {
  final Widget Function(String query) body;
  VoidCallback? setState;


  Search({
    required this.body,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return body(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => body(query),
    );
  }
}
