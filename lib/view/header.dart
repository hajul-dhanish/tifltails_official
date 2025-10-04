import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/typography.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navLinkColor = Color(0xFF6E7274);
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
           Text(
            "Tifltails",
            style: GoogleFonts.playfairDisplay(fontSize: 18),
          ),
          const Spacer(),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => openUrl("https://tifltails.com"),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Our Service",
                    style: TextStyle(
                      fontSize: 16,
                      color: navLinkColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => openUrl("https://tifltails.com"),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "About us",
                    style: TextStyle(
                      fontSize: 16,
                      color: navLinkColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => openUrl("https://tifltails.com"),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                      fontSize: 16,
                      color: navLinkColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => openUrl("https://tifltails.com"),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Join us",
                    style: TextStyle(
                      fontSize: 16,
                      color: navLinkColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const ResponsiveVisibility(
            visible: false,
            visibleConditions: [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: ImageIcon(
                  AssetImage("assets/images/icon_search_64x.png"),
                  color: navLinkColor,
                  size: 24,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => openUrl('https://twitter.com/tifltails'),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                  AssetImage("assets/images/icon_twitter_64x.png"),
                  color: navLinkColor,
                  size: 24,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => openUrl('https://www.youtube.com/tifltails'),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                  AssetImage("assets/images/icon_youtube_64x.png"),
                  color: navLinkColor,
                  size: 24,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => openUrl(
                'https://github.com/hajul-dhanish/tifltails_official',
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                  AssetImage("assets/images/icon_github_64x.png"),
                  color: navLinkColor,
                  size: 24,
                ),
              ),
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 0),
              child: TextButton(
                onPressed: () => openUrl("https://tifltails.com"),
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
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 28),
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
                  "Donate",
                  style: buttonTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
