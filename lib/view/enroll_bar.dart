import 'package:flutter/material.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/spacing.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';

class EnrollBar extends StatelessWidget {
  const EnrollBar({super.key});

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
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Enroll Today", style: headlineTextStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "It’s free and powerfull",
                  style: bodyTextStyle.copyWith(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () => openUrl("https://tifltails.com/"),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(primary),
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
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.focused) ||
                          states.contains(WidgetState.pressed)) {
                        return const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        );
                      }
                      return const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      );
                    }),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 90),
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
                      return const BorderSide(width: 3, color: Colors.white);
                    }),
                  ),
                  child: Text(
                    "Get started",
                    style: buttonTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
