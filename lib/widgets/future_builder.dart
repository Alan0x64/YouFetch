import 'package:flutter/material.dart';

class BuildFuture extends StatefulWidget {
  final Future Function()callback;
  final Function(dynamic data) builder;

  const BuildFuture({
    super.key,
    required this.callback,
    required this.builder,
  });

  @override
  State<BuildFuture> createState() => _BuildFutureState();
}

class _BuildFutureState extends State<BuildFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:widget.callback(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return widget.builder(snapshot.data);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
