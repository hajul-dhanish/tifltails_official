import 'package:flutter/material.dart' hide Banner;
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/ui/block_wrapper.dart';
import 'package:tifltails_official/ui/carousel/carousel.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/view/detail_cards/card_1.dart';
import 'package:tifltails_official/view/detail_cards/card_2.dart';
import 'package:tifltails_official/view/detail_cards/card_3.dart';
import 'package:tifltails_official/view/enroll_bar.dart';
import 'package:tifltails_official/view/features.dart';
import 'package:tifltails_official/view/footer.dart';
import 'package:tifltails_official/view/header.dart';
import 'package:tifltails_official/view/banner.dart';
import 'package:tifltails_official/view/news_bar.dart';
import 'package:tifltails_official/view/testimonial.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: Builder(
          builder: (context) {
            return ResponsiveScaledBox(
              width: ResponsiveValue<double?>(
                context,
                defaultValue: null,
                conditionalValues: [
                  const Condition.equals(name: 'MOBILE_SMALL', value: 480),
                ],
              ).value,
              child: ClampingScrollWrapper.builder(context, widget!),
            );
          },
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 480, name: 'MOBILE_SMALL'),
          const Breakpoint(start: 481, end: 850, name: MOBILE),
          const Breakpoint(start: 850, end: 1080, name: TABLET),
          const Breakpoint(start: 1081, end: double.infinity, name: DESKTOP),
        ],
      ),
      home: Scaffold(
        backgroundColor: background,
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 66),
          child: Header(),
        ),
        body: ListView.builder(
          itemCount: blocks.length,
          itemBuilder: (context, index) {
            return blocks[index];
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<Widget> blocks = [
  MaxWidthBox(
    maxWidth: 1200,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      child: Container(
        width: 1200,
        height: 640,
        alignment: Alignment.center,
        child: RepaintBoundary(child: Carousel()),
      ),
    ),
  ),
  const BlockWrapper(Banner()),
  const BlockWrapper(Features()),
  const BlockWrapper(Card1()),
  const BlockWrapper(Card2()),
  const BlockWrapper(Card3()),
  const BlockWrapper(Testimonial()),
  const BlockWrapper(NewsBar()),
  const BlockWrapper(EnrollBar()),
  const Footer(),
];
