import 'package:flutter/material.dart';
import 'package:tifltails_official/ui/carousel/model_carousel_item_animation.dart';

import 'animation_slide_up_down_fade.dart';

class CarouselSlide2 extends StatefulWidget {
  final int slideDuration;
  final RichText richText;

  const CarouselSlide2({
    super.key,
    required this.slideDuration,
    required this.richText,
  });

  @override
  State<CarouselSlide2> createState() => _CarouselSlide2State();
}

class _CarouselSlide2State extends State<CarouselSlide2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  List<SlideItemAnimationModel> slideItems = [
    SlideItemAnimationModel(
      id: "slide_3-text",
      entryDuration: 800,
      exitDuration: 500,
      entry: 34,
      exit: 157,
    ),
  ];
  final slideItemOffset = const Offset(0, 60);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: widget.slideDuration),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 200).animate(animationController)
      ..addListener(() {
        setState(() {
          slideItems = getSlideItemAnimationUpdate(animation.value, slideItems);
        });
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      height: 640,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 640,
              alignment: Alignment.center,
              child: WidgetSlideUpDownFadeAnimation(
                duration: getSlideItemAnimationDuration(
                  "slide_3-text",
                  slideItems,
                ),
                direction: getSlideItemAnimationVisibility(
                  "slide_3-text",
                  slideItems,
                ),
                offset: slideItemOffset,
                child: widget.richText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
