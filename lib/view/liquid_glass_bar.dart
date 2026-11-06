import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Floating "liquid glass" capsule for the top navigation bar.
///
/// A fully rounded pill inset from the screen edges. The page behind it stays
/// visible (light blur + saturation), with a thin clear tint, a specular
/// highlight, a slow sheen, and a gradient rim light around the capsule.
class LiquidGlassBar extends StatefulWidget {
  const LiquidGlassBar({
    super.key,
    required this.child,
    this.height = 64,
    this.maxWidth = 1240,
    this.margin = const EdgeInsets.fromLTRB(24, 12, 24, 0),
    required this.tint,
  });

  final Widget child;
  final double height;
  final double maxWidth;
  final EdgeInsets margin;
  final Color tint;

  @override
  State<LiquidGlassBar> createState() => _LiquidGlassBarState();
}

class _LiquidGlassBarState extends State<LiquidGlassBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sheen = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat();

  static final ui.ImageFilter _glassFilter = ui.ImageFilter.compose(
    outer: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
    inner: ui.ColorFilter.matrix(_saturate(1.6)),
  );

  @override
  void dispose() {
    _sheen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.height / 2);
    const white = Colors.white;

    return Padding(
      padding: widget.margin,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F241916),
                offset: Offset(0, 10),
                blurRadius: 30,
                spreadRadius: -6,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: BackdropFilter(
              filter: _glassFilter,
              child: SizedBox(
                height: widget.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Coral (#E67850) glass tint, denser at the top so white text reads.
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            widget.tint.withValues(alpha: 0.82),
                            widget.tint.withValues(alpha: 0.68),
                          ],
                        ),
                      ),
                    ),
                    // Specular highlight hugging the top curve.
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.5],
                          colors: [
                            white.withValues(alpha: 0.28),
                            white.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                    // Slow liquid sheen sweeping across.
                    IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _sheen,
                        builder: (context, _) {
                          final x = -1.8 + _sheen.value * 3.6;
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(x - 0.35, -1),
                                end: Alignment(x + 0.35, 1),
                                stops: const [0, 0.45, 0.5, 0.55, 1],
                                colors: [
                                  white.withValues(alpha: 0),
                                  white.withValues(alpha: 0.06),
                                  white.withValues(alpha: 0.22),
                                  white.withValues(alpha: 0.06),
                                  white.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Gradient rim light around the capsule.
                    IgnorePointer(
                      child: CustomPaint(
                        painter: _RimPainter(radius: widget.height / 2),
                      ),
                    ),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints a 1.2px rim that is bright at the top-left and bottom-right and
/// fades in between — the edge-refraction look of liquid glass.
class _RimPainter extends CustomPainter {
  const _RimPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(0.6),
      Radius.circular(radius),
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.35, 0.65, 1],
        colors: [
          Color(0xE6FFFFFF),
          Color(0x40FFFFFF),
          Color(0x40FFFFFF),
          Color(0xB3FFFFFF),
        ],
      ).createShader(rect);
    canvas.drawRRect(rrect, paint);

    // Faint dark outline so the capsule reads on white backgrounds too.
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(0.25), Radius.circular(radius)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5
        ..color = const Color(0x1A241916),
    );
  }

  @override
  bool shouldRepaint(covariant _RimPainter old) => old.radius != radius;
}

/// Colour matrix that saturates by [s] so colours behind the glass stay vivid.
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
