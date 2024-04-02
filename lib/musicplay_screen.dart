import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/modelclass.dart';
import 'package:media_booster/provider.dart';
import 'package:provider/provider.dart';

class musicPlayScreen extends StatefulWidget {

  final  currindex;



  musicPlayScreen({super.key,this.currindex});

  @override
  State<musicPlayScreen> createState() => _musicPlayScreenState();
}

class _musicPlayScreenState extends State<musicPlayScreen> {
  AssetsAudioPlayer musicPlayer = AssetsAudioPlayer.newPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;

  // Duration currentSlideValue = Duration.zero;

  String formatTime(int second) {
    return '${(Duration(seconds: second))}'.split('.')[0].padLeft(8, '0');
  }

  Duration currentpos = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    musicPlayer.open(Audio(musicList[widget.currindex].videoMusicURL!),
        showNotification: true, autoStart: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    musicPlayer!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabs()));
        return true;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => mainProvider())
        ],
        child: Consumer<mainProvider>(builder: (context, value, child) {
          musicPlayer.onReadyToPlay.listen((event) {
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

          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: Colors.black,
            body:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                CupertinoIcons.back,
                                size: 30,
                              ))),
                      SizedBox(height: 80),
                      Center(
                        child: Container(
                          height: 320,
                          width: 320,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 30.0,
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.white.withOpacity(.6)),
                              ],
                              borderRadius: BorderRadiusDirectional.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(musicList[widget.currindex].videoMusicImage!),fit: BoxFit.cover)
                              ),
                        ),
                      ),
                      SizedBox(height: 120,),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Text(
                          musicList[widget.currindex].videoMusicName!,style: TextStyle(fontSize: 27),
                        ),
                      ),

                      StreamBuilder(
                        stream: musicPlayer.currentPosition,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          currentpos = (snapshot.data != null)
                              ? snapshot.data
                              : const Duration(seconds: 0);

                          return Container(
                            child: Column(
                              children: [
                                Slider(
                                  value: currentpos.inSeconds.toDouble(),
                                  max: value.duration.inSeconds.toDouble(),
                                  thumbColor: Colors.white,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.black,
                                  min: 0,
                                  onChanged: (val) async {
                                    value.setPostion = Duration(
                                      seconds: val.toInt(),
                                    );

                                    await musicPlayer.seek(value.position);
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 22),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(formateTime(currentpos),
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          Text(
                                              formateTime(
                                                  value.duration - currentpos),
                                              style:
                                                  TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              size: 50,
                            ),
                            onPressed: () {
                              int rawindex = widget.currindex!;
                              if(rawindex != 0){
                                rawindex--;
                                musicPlayer.stop();
                                musicPlayer.dispose();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>musicPlayScreen(currindex: rawindex,)));
                              }
                              print('IconButton pressed ...');
                            },
                          ),
                          (isPlaying == true)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.pause_outlined,
                                    size: 75,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPlaying = false;
                                    });
                                    musicPlayer.pause();

                                    print('IconButton pressed ...');
                                  },
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPlaying = true;
                                    });
                                    musicPlayer.play();
                                  },
                                  icon: Icon(Icons.play_arrow_rounded),
                                  iconSize: 75),
                          IconButton(
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 50,
                            ),
                            onPressed: () {
                              int rawindex = widget.currindex!;
                              if(musicList.length - 1 != rawindex)
                              {
                                rawindex++;
                                musicPlayer.stop();
                                musicPlayer.dispose();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>musicPlayScreen(currindex: rawindex,) ));
                              }
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
          );
        }),
      ),
    );
  }
}
