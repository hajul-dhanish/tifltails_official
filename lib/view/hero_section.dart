import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/glass.dart';

const _heroAsset = 'assets/images/hero';

/// "Community Spotlight" landing hero: centred headline, testimonial bubble,
/// download CTA, and an iPhone mockup flanked by a tray of candid pet photos.
class CommunityHeroSection extends StatefulWidget {
  const CommunityHeroSection({super.key, required this.onDownload});

  final VoidCallback onDownload;

  @override
  State<CommunityHeroSection> createState() => _CommunityHeroSectionState();
}

class _CommunityHeroSectionState extends State<CommunityHeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1240),
      child: LayoutBuilder(builder: (context, c) => _buildContent(c.maxWidth)),
    );
  }

  Widget _buildContent(double width) {
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1000;
    final titleSize = isMobile ? 36.0 : (isTablet ? 50.0 : 64.0);

    return Column(
      children: [
        SizedBox(height: isMobile ? 36 : 56),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Text(
                  "Every tail has a story.\nEvery pet finds a family.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    letterSpacing: titleSize * -0.035,
                    color: heroInk,
                  ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Text(
                    'Find pet companions, adopt pets and track medical record and more',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 15 : 17,
                      height: 1.65,
                      color: const Color(0xFF525252),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: isMobile ? 36 : 44),
        _phoneAndPhotoTray(width),
      ],
    );
  }

  // ── Header pieces ──────────────────────────────────────────────────────────

  Widget _spotlightBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: coral50,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: coral200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.pets_rounded, size: 13, color: coral600),
          const SizedBox(width: 6),
          Text(
            'COMMUNITY SPOTLIGHT',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
              color: coral600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _testimonialBubble({required bool showDoodle}) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 460),
      padding: const EdgeInsets.fromLTRB(10, 10, 18, 10),
      decoration: BoxDecoration(
        color: white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEED7D0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12241916),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: coral200, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _photo('testimonial.jpg'),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '“All my pet records & ethical playdates in one place”',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                    color: coral600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pooja & Milo, Bangalore',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF737373),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!showDoodle) return bubble;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        bubble,
        const Positioned(
          top: -22,
          left: 40,
          child: CustomPaint(size: Size(24, 24), painter: _ArrowDoodle()),
        ),
      ],
    );
  }

  Widget _downloadButton(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 26 : 34,
        vertical: isMobile ? 16 : 18,
      ),
      decoration: BoxDecoration(
        color: coral500,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: coral500.withValues(alpha: 0.32),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Download TiflTails App',
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 15 : 16,
              fontWeight: FontWeight.w800,
              color: white,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_circle_up_rounded, size: 18, color: white),
        ],
      ),
    );
  }

  // ── Phone mockup + candid photo tray ───────────────────────────────────────

  Widget _phoneAndPhotoTray(double width) {
    final phoneWidth = width < 600 ? 284.0 : 320.0;
    // Wide: two photos per side. Tablet: one per side. Phone-sized: none.
    final photosPerSide = width >= 1060 ? 2 : (width >= 760 ? 1 : 0);
    final sideInset = width >= 1060 ? 32.0 : 20.0;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.hardEdge,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _PhoneMockup(width: phoneWidth),
          ),
          if (photosPerSide > 0)
            Positioned(
              left: sideInset,
              bottom: -18,
              child: _floating(
                phase: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _trayPhoto(
                      file: 'dogs_playing.jpg',
                      size: const Size(196, 250),
                      turns: -3,
                      label: _bottomLabel('Zero Puppy Mills', coral700),
                    ),
                    if (photosPerSide > 1) ...[
                      const SizedBox(width: 14),
                      _trayPhoto(
                        file: 'cat.jpg',
                        size: const Size(178, 196),
                        turns: 2,
                        label: _cornerChip(
                          'Adopted Indie',
                          Icons.pets_rounded,
                          const Color(0xFFF59E0B),
                          left: true,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          if (photosPerSide > 0)
            Positioned(
              right: sideInset,
              bottom: -18,
              child: _floating(
                phase: math.pi,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (photosPerSide > 1) ...[
                      _trayPhoto(
                        file: 'foster_dog.jpg',
                        size: const Size(178, 196),
                        turns: -2,
                        label: _cornerChip(
                          '100% Meal Proof',
                          Icons.rice_bowl_rounded,
                          const Color(0xFF2563EB),
                          left: false,
                        ),
                      ),
                      const SizedBox(width: 14),
                    ],
                    _trayPhoto(
                      file: 'parent_pet.jpg',
                      size: const Size(196, 250),
                      turns: 3,
                      label: _bottomLabel(
                        'Lineage Verified',
                        const Color(0xFF047857),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _floating({required double phase, required Widget child}) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, math.sin(_float.value * 2 * math.pi + phase) * 6),
        child: child,
      ),
      child: child,
    );
  }

  Widget _trayPhoto({
    required String file,
    required Size size,
    required double turns,
    required Widget label,
  }) {
    return Transform.rotate(
      angle: turns * math.pi / 180,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          // Frosted glass photo frame.
          color: white.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: white.withValues(alpha: 0.8), width: 4),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26241916),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(fit: StackFit.expand, children: [_photo(file), label]),
        ),
      ),
    );
  }

  Widget _bottomLabel(String text, Color color) {
    return Positioned(
      left: 8,
      right: 8,
      bottom: 26,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: glassDecoration(radius: 10, opacity: 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_rounded, size: 12, color: color),
            const SizedBox(width: 3),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cornerChip(
    String text,
    IconData icon,
    Color color, {
    required bool left,
  }) {
    return Positioned(
      top: 10,
      left: left ? 10 : null,
      right: left ? null : 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 10, color: white),
            const SizedBox(width: 4),
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _photo(String file) {
  return Image.asset(
    '$_heroAsset/$file',
    fit: BoxFit.cover,
    errorBuilder: (_, _, _) => Container(
      color: coral100,
      alignment: Alignment.center,
      child: const Icon(Icons.pets_rounded, color: coral300),
    ),
  );
}

// ── Phone mockup ─────────────────────────────────────────────────────────────

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({required this.width});

  final double width;

  TextStyle _t(double size, FontWeight weight, Color color) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      decoration: const BoxDecoration(
        color: Color(0xFF171717),
        borderRadius: BorderRadius.vertical(top: Radius.circular(48)),
        border: Border(
          top: BorderSide(color: Color(0xFF262626), width: 4),
          left: BorderSide(color: Color(0xFF262626), width: 4),
          right: BorderSide(color: Color(0xFF262626), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40241916),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _statusBar(),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appBar(),
                const SizedBox(height: 18),
                _myPack(),
                const SizedBox(height: 16),
                _matchCard(),
                const SizedBox(height: 12),
                _pillarPills(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBar() {
    return SizedBox(
      height: 26,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text('5:13 PM', style: _t(11, FontWeight.w600, white)),
          const Spacer(),
          Container(
            width: 84,
            height: 20,
            padding: const EdgeInsets.only(right: 8),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0x663B82F6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.signal_cellular_alt_rounded, size: 12, color: white),
          const SizedBox(width: 4),
          const Icon(Icons.battery_full_rounded, size: 13, color: white),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: coral500,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text.rich(
          TextSpan(
            text: 'Tifl',
            children: const [
              TextSpan(
                text: 'Tails',
                style: TextStyle(color: coral500),
              ),
            ],
          ),
          style: _t(13, FontWeight.w800, heroInk),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'Bangalore',
            style: _t(10, FontWeight.w700, const Color(0xFFA3A3A3)),
          ),
        ),
      ],
    );
  }

  Widget _myPack() {
    Widget pet(String name, String file, {required bool active}) {
      return Column(
        children: [
          Container(
            width: 58,
            height: 58,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: active ? coral50 : const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: active ? coral500 : const Color(0xFFE5E5E5),
                width: active ? 2 : 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _photo(file),
            ),
          ),
          const SizedBox(height: 5),
          Text(name, style: _t(11, FontWeight.w700, const Color(0xFF404040))),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'MY PACK',
              style: _t(
                12,
                FontWeight.w800,
                const Color(0xFF262626),
              ).copyWith(letterSpacing: 1),
            ),
            const Spacer(),
            Text('Edit', style: _t(11, FontWeight.w700, coral600)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            pet('Max', 'pet_max.jpg', active: true),
            const SizedBox(width: 12),
            pet('Rocky', 'pet_rocky.jpg', active: false),
            const SizedBox(width: 12),
            Column(
              children: [
                CustomPaint(
                  painter: const _DashedRRect(color: coral300, radius: 16),
                  child: Container(
                    width: 58,
                    height: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: coral50.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.add_rounded, color: coral600),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Add Pet',
                  style: _t(11, FontWeight.w500, const Color(0xFFA3A3A3)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _matchCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFF7F4), Color(0xFFFFECE6)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFAE2DA)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: coral200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      size: 11,
                      color: Color(0xFFF97316),
                    ),
                    const SizedBox(width: 2),
                    Text('98% Match', style: _t(10, FontWeight.w800, coral600)),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Adoption Ready',
                style: _t(10, FontWeight.w700, const Color(0xFFA3A3A3)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Luna (Golden Retriever)',
                      overflow: TextOverflow.ellipsis,
                      style: _t(12.5, FontWeight.w800, const Color(0xFF261714)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '✓ KCI Registered • DNA Clear',
                      overflow: TextOverflow.ellipsis,
                      style: _t(10, FontWeight.w600, const Color(0xFF047857)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: coral500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('View', style: _t(11, FontWeight.w700, white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pillarPills() {
    Widget pill(String label, IconData icon, {bool highlight = false}) {
      final fg = highlight ? const Color(0xFF1D4ED8) : const Color(0xFF404040);
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: highlight
                ? const Color(0xFFEFF6FF)
                : const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: highlight
                  ? const Color(0xFFBFDBFE)
                  : const Color(0xFFE5E5E5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: highlight ? fg : coral500),
              const SizedBox(width: 4),
              Text(label, style: _t(11, FontWeight.w700, fg)),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        pill('Mating', Icons.favorite_rounded),
        const SizedBox(width: 6),
        pill('Adopt', Icons.pets_rounded),
        const SizedBox(width: 6),
        pill('Aid', Icons.rice_bowl_rounded, highlight: true),
      ],
    );
  }
}

// ── Small helpers ────────────────────────────────────────────────────────────

/// Lifts its child slightly on hover and shows a click cursor.
class _HoverLift extends StatefulWidget {
  const _HoverLift({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          offset: Offset(0, _hover ? -0.04 : 0),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Hand-drawn curved arrow pointing at the testimonial bubble.
class _ArrowDoodle extends CustomPainter {
  const _ArrowDoodle();

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    final paint = Paint()
      ..color = coral500
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(4 * s, 14 * s)
      ..cubicTo(6 * s, 9 * s, 11 * s, 7 * s, 16 * s, 10 * s)
      ..moveTo(16 * s, 10 * s)
      ..lineTo(13 * s, 7 * s)
      ..moveTo(16 * s, 10 * s)
      ..lineTo(15 * s, 14 * s);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dashed rounded-rect outline (for the "Add Pet" tile).
class _DashedRRect extends CustomPainter {
  const _DashedRRect({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    ).deflate(1);
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      for (double d = 0; d < metric.length; d += 9) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRect old) =>
      old.color != color || old.radius != radius;
}
