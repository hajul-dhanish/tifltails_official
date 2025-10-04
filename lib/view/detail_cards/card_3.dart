import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tifltails_official/components/components.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:video_player/video_player.dart';

class Card3 extends StatefulWidget {
  const Card3({super.key});

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(
      "assets/videos/NativePerformance.mp4",
    );
    videoController.setVolume(0);
    videoController.setLooping(true);
    initializeVideoPlayerFuture = videoController.initialize().then((_) {
      if (mounted) {
        // Display the first frame of the video before playback.
        setState(() {});
        videoPlay();
      }
    });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void videoPlay() {
    videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: border),
      ),
      margin: blockMargin,
      padding: blockPadding(context),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the VideoPlayer.
                  return AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: RepaintBoundary(child: VideoPlayer(videoController)),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Container();
                }
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: buildMaterialIconCircle(Icons.pets, 68),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text(
                      "Simply Everything They Need",
                      style: headlineTextStyle,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                          text:
                              "We eliminate the hassle of pet care by consolidating all your needs—food, health, toys, training, and more—into one easy platform. Get back to playing with your pet, faster.",
                        ),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("");
                            },
                          text: "Explore our services",
                          style: bodyLinkTextStyle,
                        ),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                          text: "Will be available soon in ",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("");
                            },
                          text: "Limited Area",
                          style: bodyTextStyle.copyWith(
                            fontSize: 12,
                            color: primary,
                          ),
                        ),
                        TextSpan(
                          text: "'s ",
                          style: bodyTextStyle.copyWith(fontSize: 12),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("");
                            },
                          text: "Enroll now to get early access",
                          style: bodyTextStyle.copyWith(
                            fontSize: 12,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
