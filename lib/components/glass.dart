import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// TiflTails "liquid glass" design language — shared by every section so the
/// whole site matches the coral glass header.
///
/// * [GlassBackdrop]  – warm ambient colour field the glass refracts.
/// * [GlassPanel]     – real frosted glass (backdrop blur) for cards/panels.
/// * [glassDecoration]/[glassTintDecoration] – lightweight glass look (no blur)
///   for small chips, inputs and buttons inside panels.

/// Header coral used as the glass accent tint across the site.
const Color glassCoral = Color(0xFFE67850);

// ── Ambient backdrop ─────────────────────────────────────────────────────────

/// Fixed full-screen backdrop: warm cream base with large soft colour orbs
/// (coral, amber, sage, blush). Place it behind the scroll view; glass panels
/// scrolling over it pick up shifting colour through their blur.
class GlassBackdrop extends StatelessWidget {
  const GlassBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(painter: _OrbPainter(), size: Size.infinite),
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  const _OrbPainter();

  static const _orbs = <(Alignment, double, Color)>[
    (Alignment(-0.95, -0.85), 0.55, Color(0x59E67850)), // coral, top-left
    (Alignment(1.0, -0.55), 0.50, Color(0x4DEFC542)), // amber, top-right
    (Alignment(-0.85, 0.75), 0.55, Color(0x4781B389)), // sage, bottom-left
    (Alignment(0.95, 0.95), 0.50, Color(0x40E67850)), // coral, bottom-right
    (Alignment(0.15, 0.1), 0.40, Color(0x26FFB4A3)), // blush, centre
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFAF8), Color(0xFFFFF1EC), Color(0xFFFFF7F3)],
        ).createShader(rect),
    );
    final base = size.longestSide;
    for (final (align, r, color) in _orbs) {
      final center = align.withinRect(rect);
      final radius = base * r;
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Frosted glass panel ──────────────────────────────────────────────────────

/// Frosted glass card: backdrop blur + saturation, translucent tint that is
/// lighter at the top (specular), a gradient rim light and a soft shadow.
///
/// Wrap the page in a [BackdropGroup] so many panels share one backdrop pass.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.constraints,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.tint = Colors.white,
    this.opacity = 0.5,
    this.blur = 18,
    this.shadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final double? width;
  final BorderRadius borderRadius;
  final Color tint;

  /// Tint opacity at the top edge; the bottom is ~60% of this.
  final double opacity;

  /// Backdrop blur sigma. 0 disables the (costly) backdrop filter.
  final double blur;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    Widget glass = CustomPaint(
      foregroundPainter: _GlassRimPainter(borderRadius: borderRadius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.alphaBlend(
                Colors.white.withValues(alpha: 0.25),
                tint.withValues(alpha: opacity),
              ),
              tint.withValues(alpha: opacity * 0.6),
            ],
          ),
        ),
        child: child,
      ),
    );

    if (blur > 0) {
      glass = BackdropFilter.grouped(
        filter: ui.ImageFilter.compose(
          outer: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          inner: _saturateFilter,
        ),
        child: glass,
      );
    }

    return Container(
      width: width,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: shadow ? glassShadow : null,
      ),
      child: ClipRRect(borderRadius: borderRadius, child: glass),
    );
  }
}

/// Soft, warm, slightly lifted shadow used under glass surfaces.
const List<BoxShadow> glassShadow = [
  BoxShadow(
    color: Color(0x1A7A2E1C),
    offset: Offset(0, 14),
    blurRadius: 34,
    spreadRadius: -12,
  ),
  BoxShadow(color: Color(0x0D241916), offset: Offset(0, 2), blurRadius: 6),
];

final ui.ColorFilter _saturateFilter = ui.ColorFilter.matrix(_saturate(1.5));

List<double> _saturate(double s) {
  const lr = 0.2126, lg = 0.7152, lb = 0.0722;
  final i = 1 - s;
  return [
    i * lr + s, i * lg, i * lb, 0, 0, //
    i * lr, i * lg + s, i * lb, 0, 0, //
    i * lr, i * lg, i * lb + s, 0, 0, //
    0, 0, 0, 1, 0, //
  ];
}

/// Bright at top-left and bottom-right, faint in between — edge refraction.
class _GlassRimPainter extends CustomPainter {
  const _GlassRimPainter({required this.borderRadius});

  final BorderRadius borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRRect(
      borderRadius.toRRect(rect).deflate(0.6),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.4, 0.7, 1],
          colors: [
            Color(0xF2FFFFFF),
            Color(0x59FFFFFF),
            Color(0x40FFFFFF),
            Color(0xBFFFFFFF),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _GlassRimPainter old) =>
      old.borderRadius != borderRadius;
}

// ── Lightweight glass decorations (no blur) ──────────────────────────────────

/// Clear glass for chips, inputs and inner tiles sitting on a [GlassPanel].
BoxDecoration glassDecoration({
  double radius = 16,
  double opacity = 0.55,
  bool shadow = false,
  BoxShape shape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    shape: shape,
    borderRadius: shape == BoxShape.circle
        ? null
        : BorderRadius.circular(radius),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withValues(alpha: (opacity + 0.2).clamp(0, 1)),
        Colors.white.withValues(alpha: opacity * 0.7),
      ],
    ),
    border: Border.all(color: Colors.white.withValues(alpha: 0.75)),
    boxShadow: shadow
        ? const [
            BoxShadow(
              color: Color(0x147A2E1C),
              offset: Offset(0, 6),
              blurRadius: 16,
              spreadRadius: -6,
            ),
          ]
        : null,
  );
}

/// Coloured liquid glass — e.g. buttons and tinted tiles. Keeps [color] as
/// the body with a specular sheen on top and a bright rim.
BoxDecoration glassTintDecoration(
  Color color, {
  double radius = 24,
  double opacity = 0.85,
  bool shadow = true,
  BoxShape shape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    shape: shape,
    borderRadius: shape == BoxShape.circle
        ? null
        : BorderRadius.circular(radius),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.alphaBlend(
          Colors.white.withValues(alpha: 0.28),
          color.withValues(alpha: opacity),
        ),
        color.withValues(alpha: opacity),
        color.withValues(alpha: (opacity * 0.92).clamp(0, 1)),
      ],
      stops: const [0, 0.5, 1],
    ),
    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
    boxShadow: shadow
        ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              offset: const Offset(0, 8),
              blurRadius: 20,
              spreadRadius: -6,
            ),
          ]
        : null,
  );
}
