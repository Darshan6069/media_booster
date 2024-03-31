
import 'package:flutter/material.dart';
import 'package:media_booster/modelclass.dart';
import 'package:media_booster/videoplay_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Video',style: TextStyle(decorationStyle: TextDecorationStyle.dotted,fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.w600),),
      ),
      body:Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          itemCount: videoList.length,
          itemBuilder: (context, int index) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => videoPlayScreen(
                          video: videoList[index].videoMusicURL,
                        ),
                      ));
                    },
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              height: 180,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image:
                                      NetworkImage(videoList[index].videoMusicImage!),
                                      fit: BoxFit.cover,
                                      opacity: .6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Center(
                                      child: Text(videoList[index].videoMusicName!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
