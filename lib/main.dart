import 'package:flutter/material.dart';
import 'package:youfetch/screens/downlaod.dart';
import 'package:youfetch/util/notification.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized(); 
  await NotificationHelper.init();

  

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: DownloadScreen(),
        ));
  }
}
