import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

TextStyle get fontHeadlineDisplay => GoogleFonts.plusJakartaSans(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.02,
      height: 1.15,
      color: onSurface,
    );

TextStyle get fontHeadlineDisplayMobile => GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.02,
      height: 1.2,
      color: onSurface,
    );

TextStyle get fontHeadlineLg => GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.015,
      height: 1.25,
      color: onSurface,
    );

TextStyle get fontHeadlineLgMobile => GoogleFonts.plusJakartaSans(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.015,
      height: 1.3,
      color: onSurface,
    );

TextStyle get fontHeadlineSm => GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: onSurface,
    );

TextStyle get fontTitleMd => GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: onSurface,
    );

TextStyle get fontBodyLg => GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: onSurfaceVariant,
    );

TextStyle get fontBodyMd => GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: onSurfaceVariant,
    );

TextStyle get fontBodySm => GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: onSurfaceVariant,
    );

TextStyle get fontLabelLg => GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.01,
      height: 1.4,
      color: onSurface,
    );

TextStyle get fontLabelMd => GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.02,
      height: 1.4,
      color: onSurface,
    );

TextStyle get fontLabelCaps => GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.06,
      height: 1.45,
      color: onSurfaceVariant,
    );

// Legacy typography aliases for existing files
const String fontFamily = "Plus Jakarta Sans";
const TextStyle headlineTextStyle = TextStyle(fontSize: 44, color: onSurface, height: 1.2);
const TextStyle headlineSecondaryTextStyle = TextStyle(fontSize: 28, color: onSurface, height: 1.2);
const TextStyle bodyTextStyle = TextStyle(fontSize: 16, color: onSurfaceVariant, height: 1.5);
TextStyle bodyLinkTextStyle = bodyTextStyle.copyWith(color: primary);
const TextStyle buttonTextStyle = TextStyle(fontSize: 16, color: Colors.white, height: 1, fontWeight: FontWeight.w600);

// Legacy carousel text styles for carousel files
const TextStyle carouselBlackTextStyle = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w800,
  color: onSurface,
  height: 1.2,
);
const TextStyle carouselSecondaryTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: onSurfaceVariant,
  height: 1.5,
);
const TextStyle carouselSecondaryTextStyleAlt = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w800,
  color: primary,
  height: 1.2,
);
