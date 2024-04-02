import 'package:flutter/material.dart';
import 'package:media_booster/musicplay_screen.dart';

import 'modelclass.dart';

class musicPlayListScreen extends StatefulWidget {
  const musicPlayListScreen({super.key});

  @override
  State<musicPlayListScreen> createState() => _musicPlayListScreenState();
}

class _musicPlayListScreenState extends State<musicPlayListScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text('Music PlayList',
                style: TextStyle(
                    decorationStyle: TextDecorationStyle.dotted,
                    fontSize: 26,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600)),
            shape: Border(
                bottom: BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.white54))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height,
                width: width,
                child: ListView.builder(
                  itemCount: musicList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 75,
                        width: 300,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => musicPlayScreen(
                                      currindex: index),
                                ));
                              },
                              leading: CircleAvatar(
                                maxRadius: 35,
                                backgroundColor: Colors.red,
                                backgroundImage: NetworkImage(
                                    musicList[index].videoMusicImage!),
                              ),
                              title: Text(
                                musicList[index].videoMusicName!,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
