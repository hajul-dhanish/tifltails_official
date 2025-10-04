import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components.dart';

const String fontFamily = "Google Sans";

// Simple
const TextStyle headlineTextStyle = TextStyle(
  fontSize: 44,
  color: textPrimary,
  height: 1.2,
  fontFamily: fontFamily,
);

const TextStyle headlineSecondaryTextStyle = TextStyle(
  fontSize: 28,
  color: textPrimary,
  height: 1.2,
  fontFamily: fontFamily,
);

const TextStyle bodyTextStyle = TextStyle(
  fontSize: 16,
  color: textPrimary,
  height: 1.5,
  fontFamily: "Roboto",
);

TextStyle bodyLinkTextStyle = bodyTextStyle.copyWith(color: primary);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  height: 1,
  fontFamily: fontFamily,
);

// Carousel
TextStyle carouselBlackTextStyle = GoogleFonts.openSans(
  fontSize: 40,
  color: textPrimary,
  fontWeight: FontWeight.w800,
);
// TextStyle(
// fontSize: 40,
// color: textPrimary,
// fontFamily: fontFamily,
// fontWeight: FontWeight.w800,
// );

const TextStyle carouselPrimaryTextStyle = TextStyle(
  fontSize: 40,
  color: primary,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w800,
);

const TextStyle carouselBlueTextStyleAlter = TextStyle(
  fontSize: 40,
  color: primary,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w800,
);

const TextStyle carouselSecondaryTextStyle = TextStyle(
  fontSize: 24,
  color: primary,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
);
const TextStyle carouselSecondaryTextStyleAlt = TextStyle(
  fontSize: 60,
  color: secondary,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w300,
);
