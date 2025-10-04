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

RichText slide2Text = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'We treat your cat like ', style: carouselBlackTextStyle),
      TextSpan(
        text: 'Isreal treats Palastine',
        style: carouselSecondaryTextStyleAlt,
      ),
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slideTextAlt2 = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'We treat your dog like ', style: carouselBlackTextStyle),
      TextSpan(
        text: 'Modi treats Indians',
        style: carouselSecondaryTextStyleAlt,
      ),
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slideTextAlt3 = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'We treat your parrot like ', style: carouselBlackTextStyle),
      TextSpan(
        text: 'Taliban treats Women',
        style: carouselSecondaryTextStyleAlt,
      ),
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
