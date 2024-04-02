import 'package:flutter/material.dart';
import 'package:media_booster/music_screen.dart';
import 'package:media_booster/musicplaylistscreen.dart';
import 'package:media_booster/splash_screen.dart';
import 'package:media_booster/video_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MyHomePage(
              title: 'ds',
            ),
        '/musicPlayListScreen':(context) => musicPlayListScreen()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          width: Checkbox.width,
          child: TabBar(
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Container(
                  child: Tab(
                    text: 'Music',
                    height: 80,
                    icon: Icon(Icons.queue_music_outlined,size: 30,),
                  ),
                ),
                Container(
                  child: Tab(
                    text: 'Videos',
                    height: 80,
                    icon: Icon(Icons.video_collection_outlined,size: 30,),
                  ),
                ),
              ]),
        ),
          body: TabBarView(children: [
                musicScreen(),
              VideoScreen()
        ]),

      ),
    );
  }
}
