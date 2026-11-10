import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Header nav link for the coral liquid-glass bar.
///
/// Hover: a frosted white "glass bubble" fades in behind the label with a
/// bright rim, the label lifts slightly, and a small underline grows from the
/// centre. Press: the bubble brightens and the link scales down a touch.
/// Keyboard focus shows the same state as hover.
class GlassNavLink extends StatefulWidget {
  const GlassNavLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<GlassNavLink> createState() => _GlassNavLinkState();
}

class _GlassNavLinkState extends State<GlassNavLink> {
  bool _hovered = false;
  bool _pressed = false;

  static const _duration = Duration(milliseconds: 220);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final active = _hovered;

    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (v) => setState(() => _hovered = v),
      onShowFocusHighlight: (v) => setState(() => _hovered = v),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onTap();
            return null;
          },
        ),
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: Semantics(
          button: true,
          label: widget.label,
          child: AnimatedScale(
            scale: _pressed ? 0.75 : 1,
            duration: const Duration(milliseconds: 120),
            curve: _curve,
            child: AnimatedContainer(
              duration: _duration,
              curve: _curve,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.black.withValues(alpha: active ? 0.55 : 0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSlide(
                    duration: _duration,
                    curve: _curve,
                    offset: Offset(0, active ? -0.06 : 0),
                    child: Text(
                      widget.label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        shadows: active
                            ? const [
                                Shadow(
                                  color: Color(0x40000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Underline that grows from the centre on hover.
                  AnimatedContainer(
                    duration: _duration,
                    curve: _curve,
                    height: 2,
                    width: active ? 18 : 0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
