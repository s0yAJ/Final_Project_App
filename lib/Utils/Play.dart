import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Play extends StatefulWidget {
  final videoId;
  const Play({super.key, this.videoId});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        showLiveFullscreenButton: false,
        enableCaption: false,
        disableDragSeek: false,
      ),
    );

    _controller.addListener(() {
      if (!_controller.value.isFullScreen) {
        _controller.toggleFullScreenMode();
      }
    });

    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30,
        leading: Icon(Icons.arrow_back,color: Colors.amber[700],),
      ),
      body: YoutubePlayer(
        controller: _controller,
        onEnded: (metadata){
          Navigator.of(context).pop();
        },),
    );
  }
}
