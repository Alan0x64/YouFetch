import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:youfetch/screens/downlaod.dart';
import 'package:youfetch/screens/home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    DownloadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [AppTheme.dark(), AppTheme.light()],
      child: ThemeConsumer(
        child: Builder(
          builder: (context) => MaterialApp(
            theme: ThemeProvider.themeOf(context).data,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(title: const Text("You Fetch")),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700 ||
                      constraints.maxWidth <= 400) {
                    return const Center(
                        child: Text(
                      'Your device screen is too big or small!',
                      style: TextStyle(fontSize: 24.0),
                    ));
                  } else {
                    return IndexedStack(
                      index: _currentIndex,
                      children: _children,
                    );
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                currentIndex: _currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.file_download),
                    label: 'Download',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.book),
                  //   label: 'Library',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
