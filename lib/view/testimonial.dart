import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/spacing.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';

class Testimonial extends StatelessWidget {
  const Testimonial({super.key});

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
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 5,
            columnOrder: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Who's using Tifltails?",
                      style: headlineTextStyle,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                          text:
                              "Thousands of pet owners and animal welfare organizations across India trust Tifltails for premium care and support.",
                        ),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://tifltails.com/");
                            },
                          text: "See what’s been updated",
                          style: bodyLinkTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 7,
            columnOrder: 1,
            child: Image.asset(
              "assets/images/companies_using_flutter.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
