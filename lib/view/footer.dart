import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundDark,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).isMobile
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnMainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveRowColumnItem(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Image.asset(
                "assets/images/logo.png",
                height: 100,
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.loose,
            columnFit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: bodyTextStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      height: 2,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "tifl-tails@",
                      ),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "terms",
                      ),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "security",
                      ),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "privacy",
                      ),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "español",
                      ),
                      const TextSpan(text: "  •  "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com/");
                          },
                        text: "社区中文资源",
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: bodyTextStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1,
                    ),
                    children: [
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text:
                            "Except as otherwise noted, this work is licensed under a Creative Commons Attribution 4.0 International License, and code samples are licensed under the BSD License.",
                        style: bodyTextStyle.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(text: '\n'),
                      const TextSpan(text: '\n'),
                      const TextSpan(text: '\n'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
