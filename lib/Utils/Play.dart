import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Play extends StatefulWidget {
  final String videoId;
  final String videoTitle;
  const Play({super.key, required this.videoId, this.videoTitle = ''});

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
        showLiveFullscreenButton: true,
        enableCaption: false,
        disableDragSeek: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber[700]!,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber[700]!,
          handleColor: Colors.amber[800]!,
          bufferedColor: Colors.amber[200]!,
          backgroundColor: Colors.grey[300]!,
        ),
        onEnded: (metadata) {
          Navigator.of(context).pop();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(15, 67, 116, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(15, 67, 116, 1),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              widget.videoTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Video Player
              player,
              // Video Info Section
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.videoTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(15, 67, 116, 1),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber[700],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.play_circle_fill,
                                color: Colors.amber[700], size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Defensa Civil',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
