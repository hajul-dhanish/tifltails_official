import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/spacing.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: border),
      ),
      margin: blockMargin,
      padding: const EdgeInsets.all(40),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Made with ❤️",
                    style: headlineSecondaryTextStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text:
                            "Tifltails: Where happy homes meet wagging tails. We are on a mission to enhance the lives of pets and their parents, providing a ",
                        style: headlineSecondaryTextStyle,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "seamless and supportive ecosystem ",
                        style: headlineSecondaryTextStyle.copyWith(
                          color: primary,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "for every stage of your pet's journey. Dive into a world where ",
                        style: headlineSecondaryTextStyle,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "pet well-being ",
                        style: headlineSecondaryTextStyle.copyWith(
                          color: primary,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "is our top priority, and every furry friend finds their perfect fit.",
                        style: headlineSecondaryTextStyle,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: ResponsiveRowColumn(
                  layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  rowCrossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ResponsiveRowColumnItem(
                      child: TextButton(
                        onPressed: () => openUrl(""),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            primary,
                          ),
                          overlayColor: WidgetStateProperty.resolveWith<Color>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.hovered)) {
                              return buttonPrimaryDark;
                            }
                            if (states.contains(WidgetState.focused) ||
                                states.contains(WidgetState.pressed)) {
                              return buttonPrimaryDarkPressed;
                            }
                            return primary;
                          }),
                          // Shape sets the border radius from default 3 to 0.
                          shape:
                              WidgetStateProperty.resolveWith<OutlinedBorder>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.focused) ||
                                    states.contains(WidgetState.pressed)) {
                                  return const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  );
                                }
                                return const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                );
                              }),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 84,
                            ),
                          ),
                          // Side adds pressed highlight outline.
                          side: WidgetStateProperty.resolveWith<BorderSide>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.focused) ||
                                states.contains(WidgetState.pressed)) {
                              return const BorderSide(
                                width: 3,
                                color: buttonPrimaryPressedOutline,
                              );
                            }
                            // Transparent border placeholder as Flutter does not allow
                            // negative margins.
                            return const BorderSide(
                              width: 3,
                              color: Colors.white,
                            );
                          }),
                        ),
                        child: Text(
                          "Know more",
                          style: buttonTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextButton(
                          onPressed: () => {},
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.play_circle_filled,
                                  size: 24,
                                  color: primary,
                                ),
                              ),
                              Text(
                                "Latest updates",
                                style: buttonTextStyle.copyWith(
                                  fontSize: 16,
                                  color: primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "To know more about the us? Feeds: ",
                        style: bodyTextStyle,
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "About",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(text: ", ", style: bodyTextStyle),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "services",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(text: ", ", style: bodyTextStyle),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "Activities",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(text: ", ", style: bodyTextStyle),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "Adoption",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(text: ", ", style: bodyTextStyle),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openUrl("https://tifltails.com");
                          },
                        text: "Donation",
                        style: bodyLinkTextStyle,
                      ),
                      const TextSpan(text: ".", style: bodyTextStyle),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
