import 'package:flutter/material.dart';
import 'package:tifltails_official/components/typography.dart';

import 'animation_slide_up_down_fade.dart';
import 'model_carousel_item_animation.dart';

class CarouselSlide1 extends StatefulWidget {
  final int slideDuration;

  const CarouselSlide1({super.key, required this.slideDuration});

  @override
  State<CarouselSlide1> createState() => _CarouselSlide1State();
}

class _CarouselSlide1State extends State<CarouselSlide1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  List<SlideItemAnimationModel> slideItems = [
    SlideItemAnimationModel(
      id: "slide_1-bg",
      entryDuration: 800,
      exitDuration: 500,
      entry: 0,
      exit: 224,
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
    animation = Tween<double>(begin: 0, end: 252).animate(animationController)
      ..addListener(() {
        setState(() {
          slideItems = getSlideItemAnimationUpdate(animation.value, slideItems);
        });
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetSlideUpDownFadeAnimation(
      duration: getSlideItemAnimationDuration("slide_1-bg", slideItems),
      direction: getSlideItemAnimationVisibility("slide_1-bg", slideItems),
      offset: slideItemOffset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("One Stop Solution", style: carouselBlackTextStyle),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "for all our ",
                      style: carouselBlackTextStyle,
                    ),
                    TextSpan(text: "tifl", style: carouselSecondaryTextStyleAlt),
                    TextSpan(
                      text: " needs!",
                      style: carouselBlackTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Help us making this world a better place for pets.",
                style: carouselSecondaryTextStyle,
              ),
            ],
          ),

          Image.asset(
            "assets/images/slide_1-bg.png",
            fit: BoxFit.fill,
            height: 400,
          ),
        ],
      ),
    );
  }
}
