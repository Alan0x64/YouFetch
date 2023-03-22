import 'package:flutter/material.dart';

void snackbar(BuildContext context, String text, int duration) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    dismissDirection: DismissDirection.up,
    content: Text(text),
    duration: Duration(seconds: duration),
  ));
}
