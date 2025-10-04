import 'package:flutter/material.dart';

import 'components.dart';

Widget buildMaterialIconCircle(IconData icon, double size) {
  return Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: primaryLight,
    ),
    child: Align(
      alignment: Alignment.center,
      child: Icon(icon, size: size * 0.5, color: primary),
    ),
  );
}
