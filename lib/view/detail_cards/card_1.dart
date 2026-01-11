import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tifltails_official/components/components.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:video_player/video_player.dart';

class Card1 extends StatefulWidget {
  const Card1({super.key});

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset("assets/videos/FastDev.mp4");
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
            child: Image.asset("assets/images/card_1.png", fit: BoxFit.cover),
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
                    child: Text("Peace of Mind", style: headlineTextStyle),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                          text: "Stop worrying about what to buy. We curate ",
                        ),
                        TextSpan(
                          text:
                              "the best, safest, and most effective products recommended by vets and pet professionals, ",
                          style: bodyTextStyle.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const TextSpan(
                          text: "so you can shop with complete confidence.",
                        ),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("");
                            },
                          text: "Learn more",
                          style: bodyLinkTextStyle,
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
