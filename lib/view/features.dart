import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/icons.dart';
import 'package:tifltails_official/components/spacing.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';

class Features extends StatelessWidget {
  const Features({super.key});

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
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        columnMainAxisSize: MainAxisSize.min,
        rowPadding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        columnPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        columnSpacing: 50,
        rowSpacing: 50,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: buildMaterialIconCircle(Icons.favorite, 68),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Curated Care & Quality",
                    style: headlineSecondaryTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  "Every product and piece of advice is hand-picked by pet lovers and experts. We ensure everything from nutrition to accessories meets the highest standards, so you only get the best for your furry family.",
                  style: bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: buildMaterialIconCircle(Icons.diversity_3, 68),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "One-Stop, Easy Access",
                    style: headlineSecondaryTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  "Say goodbye to endless searching. TiflTails combines all essential pet resources—products, services, articles, and community—into one streamlined, simple-to-navigate platform.",
                  style: bodyTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: buildMaterialIconCircle(Icons.pets, 68),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Trusted Guidance & Support",
                    style: headlineSecondaryTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: bodyTextStyle,
                    children: [
                      const TextSpan(
                        text:
                            "We’re here for every stage of your pet's life. Access a wealth of reliable information and join a ",
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "supportive community ",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(
                        text:
                            "of pet parents dedicated to happy, healthy, and long-lasting companionship.",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
