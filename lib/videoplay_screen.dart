import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoPlayScreen extends StatefulWidget {

  String? video;
   videoPlayScreen({super.key,this.video});

  @override
  State<videoPlayScreen> createState() => _videoPlayScreenState();
}

class _videoPlayScreenState extends State<videoPlayScreen> {

  VideoPlayerController? playerController;
  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playerController = VideoPlayerController.asset(widget.video!);
    playerController!.initialize();
    chewieController = ChewieController(videoPlayerController: playerController!,
      autoPlay: true,
      allowPlaybackSpeedChanging: true,
      looping: false,
      fullScreenByDefault: true,
      allowFullScreen: true,



    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chewieController!.dispose();

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white,width: 1,style: BorderStyle.solid,)

              ),
              child:  Chewie( controller: chewieController!),
            ),
          ],
        ),
      ),
    );
  }
}


