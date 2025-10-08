import 'package:flutter/material.dart';
import 'package:tifltails_official/components/components.dart';

RichText slide1Text = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'One Stop Solution', style: carouselBlackTextStyle),
      TextSpan(text: ' for ', style: carouselSecondaryTextStyleAlt),
      TextSpan(text: 'All Your Pet Needs', style: carouselBlackTextStyle),
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slide3Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Available', style: carouselSecondaryTextStyleAlt),
      TextSpan(text: ' Soon', style: carouselSecondaryTextStyleAlt),
    ],
    style: TextStyle(height: 1.1),
  ),
  textAlign: TextAlign.center,
);
