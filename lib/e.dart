import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sptify/modelclass.dart';
import 'package:sptify/provider.dart';
import 'package:sptify/tab/home/home_page.dart';
import 'package:sptify/tab/tap.dart';
import 'package:sptify/top_hits/top_hits.dart';

import 'colors.dart';

class new_Display_song2 extends StatefulWidget {
  // final String? image;
  // final String? title;
  // final String? description;
  // //final bool? favorite;
  // final String? audio;
  final  currindex;

  new_Display_song2({
    // this.description,
    // this.title,
    // this.image,
    // this.audio,
    required this.currindex
    // this.favorite,
  });

  @override
  State<new_Display_song2> createState() => _Display_songState();
}

class _Display_songState extends State<new_Display_song2> {
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;

  // Duration currentSlideValue = Duration.zero;

  String formatTime(int second) {
    return '${(Duration(seconds: second))}'.split('.')[0].padLeft(8, '0');
  }
  Duration currentpos = Duration.zero;
  @override
  void dispose() {
    // TODO: implement dispose
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    player.open(Audio(audiolist[widget.currindex].audio!), showNotification: true, autoStart: false);
    // player.open(Audio(audiolist[widget.currindex!].audio!));
    // print(player.currentPosition.value.inSeconds);
    // print(player.currentPosition.value.inSeconds);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabs()));
        return true;
      },
      child: MultiProvider(
        providers: [ChangeNotifierProvider
          (create: (context)=>mainProvider())],
        child: Consumer<mainProvider>(builder: (context, value, child) {
          player.onReadyToPlay.listen((event) {
            value.setduration = event!.duration;
          });
          String formateTime(Duration duration) {
            String twoDigits(int n) => n.toString().padLeft(2, '0');
            final hours = twoDigits(duration.inHours);
            final minutes = twoDigits(duration.inMinutes.remainder(60));
            final seconds = twoDigits(duration.inSeconds.remainder(60));
            if (hours == '00' && minutes == '00' && seconds == '00') {
              value.setisPlaying = false;
            } else {
              if (currentpos != Duration.zero) {
                value.setisPlaying = true;
              }
            }
            return [
              if (duration.inHours > 0) hours,
              minutes,
              seconds,
            ].join(':');
          }

          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  audiolist[widget.currindex].image!,
                  fit: BoxFit.cover,
                ),
                Positioned(top: 60,left: 10,
                  child:  IconButton(icon: Icon(CupertinoIcons.back,color: Colors.white,size: 28,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabs()));
                      }),),

                ShaderMask(
                  blendMode: BlendMode.dstOut,
                  shaderCallback: (rect) {
                    return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: const [
                          0.4,
                          0.5,
                          0.8
                        ]).createShader(rect);
                  },
                  child: Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Duration targetPosition =
                                currentpos -
                                    Duration(seconds: 10);
                            player.seek(targetPosition);
                          },
                          icon:  Icon(
                            Icons.rotate_left,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            Duration targetPosition =
                                currentpos +
                                    const Duration(seconds: 10);
                            player.seek(targetPosition);
                          },
                          icon: const Icon(
                            Icons.rotate_right,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.green.shade100, Colors.black])),

                  ),
                ),
                Column
                  (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                            child: Text(
                              audiolist[widget.currindex].title!,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              audiolist[widget.currindex].description!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: player.currentPosition,
                            builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot)
                            {
                              currentpos = (snapshot.data != null)
                                  ? snapshot.data
                                  : const Duration(seconds: 0);

                              return Container(
                                child:  Column(
                                  children: [
                                    Slider(
                                      value: currentpos.inSeconds
                                          .toDouble(),
                                      max:
                                      value.duration.inSeconds.toDouble(),
                                      thumbColor: Colors.white,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.black,
                                      min: 0,
                                      onChanged: (val) async {
                                        value.setPostion =
                                            Duration(seconds: val.toInt(),);

                                        await player.seek(value.position);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(formateTime(
                                                  currentpos),style: TextStyle(color: Colors.white)),
                                              Text(formateTime(value.duration -
                                                  currentpos),style: TextStyle(color: Colors.white)),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }, ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              IconButton(
                                  onPressed: () {
                                    int rawindex = widget.currindex!;
                                    if(rawindex != 0){
                                      rawindex--;
                                      player.stop();
                                      player.dispose();
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>new_Display_song2(currindex: rawindex,)));
                                    }
                                  },
                                  icon: Icon(
                                    CupertinoIcons.backward_end_fill,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: ColorConstants.primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: (isPlaying == true)
                                      ? Center(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPlaying = false;
                                          });
                                          player.pause();
                                        },
                                        icon: Center(
                                            child: Icon(
                                              CupertinoIcons.pause_fill,
                                              size: 35,
                                              color: Colors.black,
                                            ))),
                                  )
                                      : Center(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPlaying = true;
                                          });
                                          player.play();
                                        },
                                        icon: Icon(
                                          CupertinoIcons.play_arrow_solid,
                                          size: 35,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    int rawindex = widget.currindex!;
                                    if(audiolist.length - 1 != rawindex)
                                    {
                                      rawindex++;
                                      player.stop();
                                      player.dispose();
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>new_Display_song2(currindex: rawindex,) ));
                                    }

                                  },
                                  icon: Icon(
                                    CupertinoIcons.forward_end_fill,
                                    color: Colors.white,
                                    size: 35,
                                  )),

                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}