import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TiflTails – Your One-Stop Pet Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NavBar(),
            _HeroSection(),
            _FeaturesSection(),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

// ─── Nav Bar ────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          // Logo + wordmark
          Image.asset('assets/images/logo.png', height: 44, fit: BoxFit.contain),
          const SizedBox(width: 8),
          Text(
            'TiflTails',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          // CTA
          _PrimaryButton(
            label: 'Download App',
            onTap: () => openUrl('https://tifltails.com'),
          ),
        ],
      ),
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 56 : 96,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF5F5), Color(0xFFFAFAFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: isMobile
          ? _HeroMobile()
          : const _HeroDesktop(),
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left – copy
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Chip(label: '🐾  Pet Care, Simplified'),
              const SizedBox(height: 24),
              Text(
                'Where happy homes\nmeet wagging tails.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'TiflTails is your all-in-one platform for pet products,\nadoption, wellness advice, and a loving community.',
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: const Color(0xFF6B6B6B),
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  _PrimaryButton(
                    label: 'Get Started',
                    onTap: () => openUrl('https://tifltails.com'),
                  ),
                  const SizedBox(width: 16),
                  _GhostButton(
                    label: 'Learn More',
                    onTap: () => openUrl('https://tifltails.com'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 64),
        // Right – illustration
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/slide_1-bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Chip(label: '🐾  Pet Care, Simplified'),
        const SizedBox(height: 20),
        Text(
          'Where happy homes\nmeet wagging tails.',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'TiflTails is your all-in-one platform for pet products, adoption, wellness advice, and a loving community.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: const Color(0xFF6B6B6B),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('assets/images/slide_1-bg.png', fit: BoxFit.cover),
        ),
        const SizedBox(height: 32),
        _PrimaryButton(
          label: 'Get Started',
          onTap: () => openUrl('https://tifltails.com'),
          fullWidth: true,
        ),
      ],
    );
  }
}

// ─── Features ────────────────────────────────────────────────────────────────

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  static const _items = [
    _FeatureItem(
      icon: Icons.favorite_rounded,
      title: 'Curated Care & Quality',
      body:
          'Every product and piece of advice is hand-picked by pet experts to ensure the highest standards for your furry family.',
    ),
    _FeatureItem(
      icon: Icons.hub_rounded,
      title: 'One-Stop Access',
      body:
          'Products, services, articles, and community — all in one streamlined, simple-to-navigate platform.',
    ),
    _FeatureItem(
      icon: Icons.pets_rounded,
      title: 'Trusted Guidance',
      body:
          'Access reliable information and a supportive community of pet parents dedicated to happy, healthy companionship.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 48 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Everything your pet needs',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 26 : 34,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Built for pet lovers, by pet lovers.',
            style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF8C8C8C)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
                  children: _items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _FeatureCard(item: item),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _items
                      .map(
                        (item) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: _FeatureCard(item: item),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String body;
  const _FeatureItem({required this.icon, required this.title, required this.body});
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem item;
  const _FeatureCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: primary, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.body,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B6B6B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 32,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _footerLogo(),
                const SizedBox(height: 20),
                _footerLinks(context),
                const SizedBox(height: 20),
                _footerCopy(),
              ],
            )
          : Row(
              children: [
                _footerLogo(),
                const Spacer(),
                _footerLinks(context),
                const Spacer(),
                _footerCopy(),
              ],
            ),
    );
  }

  Widget _footerLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/logo.png',
            height: 32, color: Colors.white, fit: BoxFit.contain),
        const SizedBox(width: 8),
        Text(
          'TiflTails',
          style: GoogleFonts.playfairDisplay(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _footerLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterLink(label: 'Privacy Policy', onTap: () => openUrl('https://tifltails.com/privacy-policy')),
        const SizedBox(width: 20),
        _FooterLink(label: 'Contact', onTap: () => openUrl('mailto:hello@tifltails.com')),
      ],
    );
  }

  Widget _footerCopy() {
    return Text(
      '© 2026 TiflTails',
      style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF8C8C8C)),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFFAAAAAA),
          ),
        ),
      ),
    );
  }
}

// ─── Shared UI primitives ─────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;
  const _PrimaryButton({required this.label, required this.onTap, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    final btn = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: Center(child: btn)) : btn;
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDDDDDD)),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4A4A4A),
            ),
          ),
        ),
      ),
    );
  }
}
