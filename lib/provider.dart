import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class mainProvider with ChangeNotifier{
  bool _isMute = false;
  bool get isMute => isMute;

  Duration postion = Duration.zero;
  Duration _duration = Duration.zero;

  Duration get position => position;

  Duration get duration => _duration;
  bool _isPlaying = true;

  bool get isPlaying => _isPlaying;
  ChewieController? chewieController;
  late VideoPlayerController videoPlayerController;

  disposeMethod() {
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  set setduration(value) {
    _duration = value;
    notifyListeners();
  }

  set setisPlaying(value) {
    _isPlaying = value;
    notifyListeners();
  }

  set setMute(value) {
    _isMute = !value;

    notifyListeners();
  }

  set setPostion(newpositon) {
    postion = newpositon;
    notifyListeners();
  }

}