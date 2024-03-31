import 'package:flutter/material.dart';
import 'package:media_booster/modelclass.dart';

import 'musicplay_screen.dart';

class musicScreen extends StatefulWidget {
  const musicScreen({super.key});

  @override
  State<musicScreen> createState() => _musicScreenState();
}

class _musicScreenState extends State<musicScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Music',style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.w600),),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Treding Song',style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 26,letterSpacing: 1,fontWeight: FontWeight.w600)),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/musicPlayListScreen');
                  },
                  child: Text('SEE MORE'))
            ],
          ),
          Container(
            height: 208,
            width: width,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => musicPlayScreen(
                            musicURL: musicList[index].videoMusicURL,
                            musicName: musicList[index].videoMusicName,
                        musicImage: musicList[index].videoMusicImage),
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          color: Colors.green,
                          child: Image.network(
                            musicList[index].videoMusicImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(musicList[index].videoMusicName!,style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(endIndent: 10,indent: 10,height: 10,thickness: 2,color: Colors.white38,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Most Played',style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 26,letterSpacing: 1,fontWeight: FontWeight.w600)),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/musicPlayListScreen');
                  },
                  child: Text('SEE MORE'))
            ],
          ),
          Container(
            height: 208,
            width: width,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => musicPlayScreen(
                            musicURL: musicList[index].videoMusicURL,
                            musicName: musicList[index].videoMusicName,
                            musicImage: musicList[index].videoMusicImage),
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          color: Colors.green,
                          child: Image.network(
                            musicList[index].videoMusicImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(musicList[index].videoMusicName!,style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(endIndent: 10,indent: 10,height: 10,thickness: 2,color: Colors.white38,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Song',style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 26,letterSpacing: 1,fontWeight: FontWeight.w600)),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/musicPlayListScreen');
                  },
                  child: Text('SEE MORE'))
            ],
          ),
          Container(
            height: 208,
            width: width,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => musicPlayScreen(
                            musicURL: musicList[index].videoMusicURL,
                            musicName: musicList[index].videoMusicName,
                            musicImage: musicList[index].videoMusicImage),
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          color: Colors.green,
                          child: Image.network(
                            musicList[index].videoMusicImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(musicList[index].videoMusicName!,style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
