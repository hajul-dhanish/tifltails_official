import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/components/glass.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:tifltails_official/view/glass_nav_link.dart';
import 'package:tifltails_official/view/hero_section.dart';
import 'package:tifltails_official/view/liquid_glass_bar.dart';
import 'package:tifltails_official/view/privacy_policy_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TiflTails - Your One-Stop Pet Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: primaryContainer,
          secondary: secondary,
          onSecondary: onSecondary,
          surface: Colors.white,
          onSurface: onSurface,
          onSurfaceVariant: onSurfaceVariant,
          outline: outline,
          outlineVariant: outlineVariant,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/privacy-policy': (context) => const PrivacyPolicyPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Global keys for smooth in-page anchor scrolling
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _shopKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _downloadKey = GlobalKey();

  // Shop View state: 'front', 'back'
  String _activeShopView = 'front';

  // Contact form state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedCategory = 'Pet Adoption & Foster';
  bool _formSubmitted = false;

  // FAQ Expanded indices
  final Set<int> _expandedFaqIndices = {0};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _scrollTo(_contactKey);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Scrollable Content
          BackdropGroup(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top spacing behind fixed navbar
                  const SizedBox(height: 76),

                  // SECTION 1: HERO
                  Container(key: _aboutKey, child: _buildHeroSection(isMobile)),

                  // SECTION 2: APP PILLAR FEATURES
                  Container(
                    key: _featuresKey,
                    child: _buildAppFeaturesSection(isMobile),
                  ),

                  // SECTION 3: FEATURED PRODUCT SHOWCASE (SHOP)
                  Container(key: _shopKey, child: _buildShopSection(isMobile)),

                  // SECTION 4: CONTACT & ENQUIRY FORM
                  Container(
                    key: _contactKey,
                    child: _buildContactSection(isMobile),
                  ),

                  // SECTION 5: FAQ & QUICK ANSWERS
                  Container(key: _faqKey, child: _buildFaqSection(isMobile)),

                  // SECTION 6: APP DOWNLOAD CTA BANNER
                  Container(
                    key: _downloadKey,
                    child: _buildDownloadCtaSection(isMobile),
                  ),

                  // COMPREHENSIVE FOOTER
                  _buildFooter(isMobile),
                ],
              ),
            ),
          ),

          // FIXED TOP NAVIGATION BAR
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeaderNavBar(isMobile),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // HEADER & NAVIGATION BAR
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildHeaderNavBar(bool isMobile) {
    // Floating liquid-glass capsule (12px top inset + 64px bar = the 76px
    // spacer at the top of the page).
    return LiquidGlassBar(tint: white, child: _buildHeaderContent(isMobile));
  }

  Widget _buildHeaderContent(bool isMobile) {
    return Padding(
      // Tight right inset so the Download pill sits snug in the capsule end.
      padding: EdgeInsets.only(
        left: isMobile ? 14 : 26,
        right: isMobile ? 4 : 8,
      ),
      child: Row(
        children: [
          // Brand Logo & Wordmark
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _scrollTo(_aboutKey),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      width: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ONE STOP PET PLATFORM',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: black,
                          // letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isMobile) ...[
            SizedBox(width: 16),
            Container(
              color: black.withValues(alpha: 0.6),
              height: 20,
              width: 1,
            ),

            // const Spacer(),
            // Desktop Navigation Links
            Row(
              children: [
                if (!isMobile) ...[
                  _navLink('About', () => _scrollTo(_aboutKey)),
                  _navLink('App Features', () => _scrollTo(_featuresKey)),
                  _navLink('Services', () => _scrollTo(_featuresKey)),
                  _navLink('Shop', () => _scrollTo(_shopKey)),
                  _navLink('Contact', () => _scrollTo(_contactKey)),
                  const SizedBox(width: 12),
                ],
              ],
            ),
            Spacer(),
            // Download CTA Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _scrollTo(_downloadKey),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 14 : 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x209F3B24),
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.download_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Download App',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          // Mobile Menu Popup
          if (isMobile) ...[
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: black),
              color: surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onSelected: (value) {
                if (value == 'about') _scrollTo(_aboutKey);
                if (value == 'features') _scrollTo(_featuresKey);
                if (value == 'shop') _scrollTo(_shopKey);
                if (value == 'contact') _scrollTo(_contactKey);
                if (value == 'download') _scrollTo(_downloadKey);
                if (value == 'privacy') {
                  Navigator.of(context).pushNamed('/privacy-policy');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'about', child: Text('About')),
                const PopupMenuItem(
                  value: 'features',
                  child: Text('App Features & Services'),
                ),
                const PopupMenuItem(
                  value: 'shop',
                  child: Text('Pet Food & Treats'),
                ),
                const PopupMenuItem(
                  value: 'contact',
                  child: Text('Contact Us'),
                ),
                const PopupMenuItem(
                  value: 'download',
                  child: Text('Get Mobile App'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'privacy',
                  child: Text('Privacy Policy'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _navLink(String label, VoidCallback onTap) {
    return GlassNavLink(label: label, onTap: onTap);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 1: HERO SECTION
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildHeroSection(bool isMobile) {
    return CommunityHeroSection(onDownload: () => _scrollTo(_downloadKey));
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 2: MOBILE APPLICATION ECOSYSTEM (PILLARS)
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildAppFeaturesSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.touch_app_rounded,
                              size: 16,
                              color: primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'MOBILE APPLICATION ECOSYSTEM',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Everything Your Pet Needs, Right in Your Pocket',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 26 : 34,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                            color: onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Empowering responsible pet parents with transparent shelters, certified mating, and real-time medical community aids.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: glassDecoration(
                        radius: 24,
                        opacity: 0.6,
                        shadow: true,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified_user_rounded,
                            size: 18,
                            color: primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Zero Unethical Breeding Guarantee',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),

              // 4 Cards Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth > 900
                      ? (constraints.maxWidth - 48) / 4
                      : constraints.maxWidth > 600
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        height: isMobile ? null : 400,
                        child: _featureCard(
                          pillar: 'PILLAR 01',
                          title: 'Pet Adoption',
                          desc:
                              'Verified shelter and foster listings with strict ethical protocols. Connect directly with local rescuers and match pets based on your lifestyle, yard, and family vibe.',
                          tags: ['Rescue Pups', 'Foster Homes', 'Home Checks'],
                          icon: Icons.volunteer_activism_rounded,
                          iconBg: secondaryFixed,
                          iconColor: secondary,
                          pillarColor: secondary,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        height: isMobile ? null : 400,

                        child: _featureCard(
                          pillar: 'PILLAR 02',
                          title: 'Pet Matchmaking',
                          desc:
                              'Tinder for loving companions. Verified breed profiles, genetic lineage checks, complete health credential validation, and ethical companionship discovery.',
                          tags: [
                            'Lineage Verified',
                            'Health Records',
                            'Ethical Mating',
                          ],
                          icon: Icons.favorite_rounded,
                          iconBg: primaryFixed,
                          iconColor: primary,
                          pillarColor: primary,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        height: isMobile ? null : 400,

                        child: _featureCard(
                          pillar: 'PILLAR 03',
                          title: 'Health & Reminders',
                          desc:
                              'Never miss a step in their healthcare journey, Stay ahead of your pet\'s health with timely vaccination and deworming reminders. Keep track of upcoming schedules and due dates.',
                          tags: [
                            'Vaccine Reminders',
                            'Deworming Alerts',
                            'Health Schedules',
                          ],
                          icon: Icons.schedule,
                          iconBg: tertiaryFixed,
                          iconColor: tertiaryContainer,
                          pillarColor: tertiaryContainer,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        height: isMobile ? null : 400,

                        child: _roadmapCard(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureCard({
    required String pillar,
    required String title,
    required String desc,
    required List<String> tags,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Color pillarColor,
  }) {
    return GlassPanel(
      tint: surfaceDim,
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: glassTintDecoration(
              iconBg,
              radius: 16,
              opacity: 0.75,
              shadow: false,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(height: 18),
          Text(
            pillar,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: pillarColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: glassDecoration(radius: 12, opacity: 0.45),
                    child: Text(
                      t,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _roadmapCard() {
    return GlassPanel(
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(20),
      tint: surfaceContainerHighest,
      opacity: 0.55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: glassDecoration(radius: 16, opacity: 0.7),
            child: const Icon(
              Icons.rocket_launch_rounded,
              color: onSurfaceVariant,
              size: 26,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'NEXT IN PIPELINE',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'More Coming Soon',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '24/7 video tele-vet visits, peer-to-peer neighborhood dog walking groups, at-home grooming, and cloud pet passports.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _scrollTo(_downloadKey),
              child: Row(
                children: [
                  Text(
                    'Stay Notified on App Store',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 3: FEATURED PRODUCT SHOWCASE (SHOP)
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildShopSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: GlassPanel(
          tint: surfaceDim,
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(isMobile ? 20 : 36),
          borderRadius: BorderRadius.circular(28),
          child: isMobile
              ? Column(
                  children: [
                    _buildPouchViewer(isMobile),
                    const SizedBox(height: 36),
                    _buildProductDetails(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildPouchViewer(isMobile)),
                    const SizedBox(width: 48),
                    Expanded(flex: 7, child: _buildProductDetails()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildPouchViewer(bool isMobile) {
    const frontUrl =
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBYx30uuKTnPs8DX12zq2Mdd7hdN1dKID_WNXbCfX1t6UN-NOie0yb4TSueAYDcEGy7lRFnBfzrHfvCa_W0nSWCeEOkvxykENfaK_RDUZi51I0t4oDSohNw0uuulyxdnqcZHVsAu_YYzeGJUe2tvkctkSbg7Rp7Dc7qQuyTIJgOYkEN7zMHrbX2AxRqXNBcGBBV7z9y-FxRLzGs5G0nxNyZAJz_x2TOuRLO2JHgR-y-l8EOWccTepI';
    const backUrl =
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCZsZWuVlSFf1MQVhSmT12RwyYZNjF7wD6EZH7AwZKMnfolv6iwF3Taz6xVNK_dElDz7IsFMe6B-_qY6BaaLD-gNu2a6qnoMTKvIllPmyPhs1JU7BMMitgjSuoRlkqMLbEwlATqsH6URq_vD4UroERorv0SySh9x_ZcqP4xHQfFkmWXqQsPR_Rln-GpTTiiE82RwNaLMja836gTUplwTjlScI80qlVz1FNVuXaW_RpFV6rn0moIh5g';

    return Column(
      children: [
        // Pouch Display Box
        Container(
          constraints: const BoxConstraints(maxWidth: 380, maxHeight: 440),
          decoration: glassDecoration(radius: 24, opacity: 0.35),
          child: Stack(
            children: [
              // Image Loader with Fallback Graphic
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.network(
                    _activeShopView == 'front' ? frontUrl : backUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        _pouchFallbackCard(),
                  ),
                ),
              ),

              // Badges
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: glassDecoration(
                    radius: 16,
                    opacity: 0.7,
                    shadow: true,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '100g Net Weight',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: glassDecoration(
                    radius: 16,
                    opacity: 0.7,
                    shadow: true,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.eco_rounded, size: 14, color: secondary),
                      const SizedBox(width: 4),
                      Text(
                        'Farm Fresh',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Toggle Buttons
        Container(
          padding: const EdgeInsets.all(5),
          decoration: glassDecoration(radius: 24, opacity: 0.45),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _shopToggleButton('front', 'Front Pouch'),
              const SizedBox(width: 4),
              _shopToggleButton('back', 'Back Label & Guide'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pouchFallbackCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: glassDecoration(radius: 18, opacity: 0.7, shadow: true),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.pets, size: 54, color: primary),
          const SizedBox(height: 12),
          Text(
            'TiflTails Dog Treats',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _activeShopView == 'front'
                ? 'Natural Dehydrated Chicken Chews (100g)'
                : 'Nutrition: 47.3% Protein • 476 kcal/100g',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopToggleButton(String viewKey, String label) {
    final isSelected = _activeShopView == viewKey;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeShopView = viewKey;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: isSelected
              ? glassTintDecoration(primary, radius: 20, shadow: false)
              : BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.white : onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: glassTintDecoration(
            primary,
            radius: 16,
            opacity: 0.14,
            shadow: false,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, size: 14, color: primary),
              const SizedBox(width: 6),
              Text(
                '100% SINGLE INGREDIENT DOG TREAT',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'TiflTails Dog Treats',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: onSurface,
          ),
        ),
        Text(
          'Natural Dehydrated Chicken Chews (100g)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Crafted exclusively from clean farm-fresh chicken, naturally dehydrated to preserve high levels of glucosamine and chondroitin for healthy joints while gently cleaning teeth through chew action.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),

        // 3 Key highlights
        Row(
          children: [
            Expanded(
              child: _productPill(
                Icons.check_circle_rounded,
                'No Additives',
                'Zero Preservatives',
                primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _productPill(
                Icons.spa_rounded,
                'Farm Fresh',
                'Single Source',
                secondary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _productPill(
                Icons.grain_rounded,
                'Grain Free',
                'All Life Stages',
                tertiaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Nutritional highlights table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: glassDecoration(radius: 16, opacity: 0.4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NUTRITIONAL ANALYSIS HIGHLIGHTS',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                  ),
                  Text(
                    'Tested per 100g',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _nutritionStat('Crude Protein', '47.3%', primary),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _nutritionStat(
                      'Energy Value',
                      '476 kcal',
                      secondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _nutritionStat(
                      'Crude Fat',
                      '31.1%',
                      tertiaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _onCategorySelected(
                  'Product Purchase (TiflTails Dog Treats 100g)',
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 13,
                  ),
                  decoration: glassTintDecoration(primary, radius: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shopping_bag_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Order Treats / Inquire Pack',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productPill(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: glassDecoration(radius: 14, opacity: 0.5),
      child: Column(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutritionStat(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: glassDecoration(radius: 12, opacity: 0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 4: INTERACTIVE ENQUIRY & CONTACT FORM
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildContactSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildContactDetails(),
                    const SizedBox(height: 36),
                    _buildContactForm(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildContactDetails()),
                    const SizedBox(width: 48),
                    Expanded(flex: 7, child: _buildContactForm()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.support_agent_rounded, size: 16, color: primary),
            const SizedBox(width: 6),
            Text(
              'DIRECT COMMUNICATION',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Get In Touch With TiflTails',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Have a question regarding pet adoptions, pedigree matchmaking, NGO onboarding, or bulk orders of our Duo-Care Kit? Reach out directly to our pet happiness team.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Email card
        _contactInfoCard(
          icon: Icons.mail_outline_rounded,
          iconBg: primaryFixed,
          iconColor: primary,
          title: 'Email Us Directly',
          mainText: 'contact@tifltails.com',
          subtitle: 'Direct inbox response within 2 hours',
          onTap: () => openUrl('mailto:contact@tifltails.com'),
        ),
        const SizedBox(height: 12),

        // Phone card
        _contactInfoCard(
          icon: Icons.call_outlined,
          iconBg: secondaryFixed,
          iconColor: secondary,
          title: 'Call or WhatsApp',
          mainText: '+91 9600000000',
          subtitle: 'Mon - Sat, 9:00 AM - 8:00 PM IST',
          onTap: () => openUrl('tel:+919600000000'),
        ),
        const SizedBox(height: 12),

        // Official portal card
        _contactInfoCard(
          icon: Icons.public_rounded,
          iconBg: surfaceContainerHigh,
          iconColor: onSurface,
          title: 'Official Portal',
          mainText: 'tifltails.com',
          subtitle: 'Registered Pet Parent Community Platform',
          onTap: () => openUrl('https://tifltails.com'),
        ),
        const SizedBox(height: 20),

        // Privacy Promise
        Container(
          padding: const EdgeInsets.all(16),
          decoration: glassTintDecoration(
            surfaceContainer,
            radius: 16,
            opacity: 0.35,
            shadow: false,
          ),
          child: Row(
            children: [
              const Icon(Icons.verified_rounded, size: 28, color: primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Promise',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                      ),
                    ),
                    Text(
                      'We never share your personal numbers or pet profiles with third-party advertisers.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactInfoCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String mainText,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: GlassPanel(
          tint: surfaceDim,
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(16),
          blur: 12,
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: glassTintDecoration(
                  iconBg,
                  shape: BoxShape.circle,
                  opacity: 0.8,
                  shadow: false,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mainText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return GlassPanel(
      tint: surfaceDim,
      padding: const EdgeInsets.all(32),
      borderRadius: BorderRadius.circular(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send an Enquiry',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: onSurface,
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: onSurfaceVariant,
                ),
                children: const [
                  TextSpan(text: 'Enquiries are dispatched directly to '),
                  TextSpan(
                    text: 'contact@tifltails.com',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Success Banner
            if (_formSubmitted) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: glassTintDecoration(
                  secondaryFixed,
                  radius: 14,
                  opacity: 0.7,
                  shadow: false,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: secondary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thank you! Your message was sent.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: onSecondaryFixed,
                            ),
                          ),
                          Text(
                            'A notification has been directed to contact@tifltails.com. Our coordinator will reply shortly.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: onSecondaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Full Name & Email
            Row(
              children: [
                Expanded(
                  child: _formField(
                    label: 'Full Name *',
                    hint: 'e.g. Priya Sharma',
                    controller: _nameController,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _formField(
                    label: 'Email Address *',
                    hint: 'priya@example.com',
                    controller: _emailController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Mobile & Category
            Row(
              children: [
                Expanded(
                  child: _formField(
                    label: 'Mobile Number',
                    hint: '+91 96000 00000',
                    controller: _phoneController,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interested Category *',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: glassDecoration(radius: 10, opacity: 0.55),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: primary,
                            ),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: onSurface,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Pet Adoption & Foster',
                                child: Text('Pet Adoption & Foster'),
                              ),
                              DropdownMenuItem(
                                value: 'Pet Mating / Matchmaking',
                                child: Text('Pet Mating / Matchmaking'),
                              ),
                              DropdownMenuItem(
                                value: 'NGO Donation & Shelter Support',
                                child: Text('NGO Donation & Shelter Support'),
                              ),
                              DropdownMenuItem(
                                value:
                                    'Product Purchase (TiflTails Dog Treats 100g)',
                                child: Text(
                                  'Product Purchase (Dog Treats 100g)',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'General Enquiry / Partnership',
                                child: Text('General Enquiry / Partnership'),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedCategory = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              'Your Message *',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: glassDecoration(radius: 10, opacity: 0.55),
              child: TextField(
                controller: _messageController,
                maxLines: 4,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: onSurface,
                ),
                decoration: InputDecoration(
                  hintText:
                      'Tell us about your pet, adoption preferences, or order details...',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: outline.withValues(alpha: 0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final message = _messageController.text.trim();
                  final phone = _phoneController.text.trim();

                  // Open email client with form contents as fallback
                  final subject = Uri.encodeComponent(
                    'TiflTails Enquiry: $_selectedCategory ($name)',
                  );
                  final body = Uri.encodeComponent(
                    'Name: $name\nEmail: $email\nPhone: $phone\nCategory: $_selectedCategory\n\nMessage:\n$message',
                  );
                  openUrl(
                    'mailto:contact@tifltails.com?subject=$subject&body=$body',
                  );

                  setState(() {
                    _formSubmitted = true;
                    _nameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _messageController.clear();
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: glassTintDecoration(primary, radius: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.send_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Send Enquiry',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: glassDecoration(radius: 10, opacity: 0.55),
          child: TextField(
            controller: controller,
            style: GoogleFonts.plusJakartaSans(fontSize: 13, color: onSurface),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: outline.withValues(alpha: 0.7),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 5: FAQ & QUICK ANSWERS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildFaqSection(bool isMobile) {
    final faqs = [
      {
        'q': 'How does the Pet Mating verification ensure ethical breeding?',
        'a':
            'Every pet profile submitted for mating matchmaking requires mandatory vaccination records, a recent veterinary fitness certificate, and pedigree/lineage documentation. We prohibit commercial mills and inspect profiles to ensure minimum recommended breeding age and humane inter-litter intervals.',
      },
      {
        'q': 'What are the requirements for adopting a rescue companion?',
        'a':
            'Adoptions on TiflTails require filling out a friendly lifestyle questionnaire, coordinating a digital or in-person home check with the verified shelter, and signing a no-abandonment agreement. Rescues are dewormed and neutered/spayed according to age guidelines prior to handoff.',
      },
      {
        'q': 'How does TiflTails guarantee 100% NGO donation transparency?',
        'a':
            'We operate zero platform commissions on charitable drives. All funds raised are credited directly to verified 80G/12A compliant animal trusts. Every emergency food drive and medical treatment publishes photographic invoices and doctor prescription receipts right in your donor feed.',
      },
      {
        'q':
            'What is the delivery time and storage policy for TiflTails Dog Treats?',
        'a':
            'All orders for TiflTails Dog Treats (100g) are dispatched within 24–48 business hours with temperature-sealed packaging and express tracking. Once received and opened, please refrigerate immediately to ensure fresh single-ingredient goodness for up to one full month.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'GOT QUESTIONS?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Everything you need to know about our safety standards, adoption protocols, and services.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 36),

              // Accordion items
              ...List.generate(faqs.length, (index) {
                final isExpanded = _expandedFaqIndices.contains(index);
                return GlassPanel(
                  margin: const EdgeInsets.only(bottom: 12),
                  borderRadius: BorderRadius.circular(16),
                  blur: 12,
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          if (expanded) {
                            _expandedFaqIndices.add(index);
                          } else {
                            _expandedFaqIndices.remove(index);
                          }
                        });
                      },
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      title: Text(
                        faqs[index]['q']!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: onSurface,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                        color: primary,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                          child: Text(
                            faqs[index]['a']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: onSurfaceVariant,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SECTION 6: APP DOWNLOAD CTA BANNER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildDownloadCtaSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 32 : 48,
      ),
      child: Center(
        child: GlassPanel(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          borderRadius: BorderRadius.circular(28),
          tint: primary,
          opacity: 0.82,
          child: isMobile
              ? Column(
                  children: [
                    _buildDownloadText(isMobile),
                    const SizedBox(height: 24),
                    _buildStoreButtons(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildDownloadText(isMobile)),
                    const SizedBox(width: 32),
                    _buildStoreButtons(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildDownloadText(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'READY FOR HAPPY TAILS?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            color: primaryFixed,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Download TiflTails on Android & iOS Today',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join thousands of conscientious pet parents finding best-fit matches, adoption companions, and vet-approved products in one friendly place.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: primaryFixed.withValues(alpha: 0.95),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStoreButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => openUrl('https://play.google.com'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: glassDecoration(
                radius: 14,
                opacity: 0.75,
                shadow: true,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    size: 28,
                    color: primary,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GET IT ON',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'Google Play',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => openUrl('https://apple.com/app-store/'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: glassDecoration(
                radius: 14,
                opacity: 0.75,
                shadow: true,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.smartphone_rounded,
                    size: 26,
                    color: primary,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DOWNLOAD ON THE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'iOS App Store',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // COMPREHENSIVE FOOTER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildFooter(bool isMobile) {
    return GlassPanel(
      width: double.infinity,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      opacity: 0.45,
      shadow: false,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 36,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // 4 Columns
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _footerBrandColumn(),
                        const SizedBox(height: 28),
                        _footerExplorerColumn(),
                        const SizedBox(height: 28),
                        _footerContactColumn(),
                        const SizedBox(height: 28),
                        _footerAppColumn(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: _footerBrandColumn()),
                        const SizedBox(width: 32),
                        Expanded(flex: 3, child: _footerExplorerColumn()),
                        const SizedBox(width: 32),
                        Expanded(flex: 2, child: _footerContactColumn()),
                        const SizedBox(width: 32),
                        Expanded(flex: 3, child: _footerAppColumn()),
                      ],
                    ),

              const SizedBox(height: 36),
              const Divider(color: Color(0x2057423D)),
              const SizedBox(height: 20),

              // Bottom bar
              Row(
                children: [
                  const Icon(Icons.pets, size: 14, color: primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '© 2026 TiflTails Platform (tifltails.com). Built with love for pets and their humans.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (!isMobile) ...[
                    _footerTextLink('Privacy Policy', () {
                      Navigator.of(context).pushNamed('/privacy-policy');
                    }),
                    const SizedBox(width: 16),
                    _footerTextLink('Terms of Service', () {
                      openUrl('https://tifltails.com/');
                    }),
                    const SizedBox(width: 16),
                    _footerTextLink('Support Desk', () {
                      _scrollTo(_contactKey);
                    }),
                  ],
                ],
              ),
              if (isMobile) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _footerTextLink('Privacy Policy', () {
                      Navigator.of(context).pushNamed('/privacy-policy');
                    }),
                    const SizedBox(width: 16),
                    _footerTextLink('Terms of Service', () {
                      openUrl('https://tifltails.com/');
                    }),
                    const SizedBox(width: 16),
                    _footerTextLink('Support Desk', () {
                      _scrollTo(_contactKey);
                    }),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo.png',
                height: 34,
                width: 34,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TiflTails',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
                Text(
                  'tifltails.com',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Your trusted one-stop pet ecosystem designed with warm Scandinavian simplicity. Connecting pet parents, verified adoptees, ethical mating matches, and shelters under one caring roof.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.pets, size: 16, color: primary),
            const SizedBox(width: 6),
            Text(
              'Happy tails, healthy journeys',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.favorite, size: 16, color: secondary),
          ],
        ),
      ],
    );
  }

  Widget _footerExplorerColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Platform Explorer',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 12),
        _footerExplorerLink('About Our Community', () => _scrollTo(_aboutKey)),
        _footerExplorerLink(
          'Pet Adoption & Rescue',
          () => _scrollTo(_featuresKey),
        ),
        _footerExplorerLink(
          'Responsible Pet Mating',
          () => _scrollTo(_featuresKey),
        ),
        _footerExplorerLink(
          'NGO Donations & Aid',
          () => _scrollTo(_featuresKey),
        ),
        _footerExplorerLink('Featured Pet Shop', () => _scrollTo(_shopKey)),
      ],
    );
  }

  Widget _footerExplorerLink(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direct Contact',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 12),
        _footerContactItem(
          Icons.call_rounded,
          '+91 9600000000',
          () => openUrl('tel:+919600000000'),
        ),
        _footerContactItem(
          Icons.mail_rounded,
          'contact@tifltails.com',
          () => openUrl('mailto:contact@tifltails.com'),
        ),
        _footerContactItem(
          Icons.support_rounded,
          'support@tifltails.com',
          () => openUrl('mailto:support@tifltails.com'),
        ),
        _footerContactItem(
          Icons.public_rounded,
          'tifltails.com',
          () => openUrl('https://tifltails.com'),
        ),
      ],
    );
  }

  Widget _footerContactItem(IconData icon, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(icon, size: 15, color: primary),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerAppColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get the Mobile App',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Carry your vet logs, community feeds, and pet mating profiles in your pocket.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        _storeMiniButton(
          Icons.play_arrow_rounded,
          'Get it on',
          'Google Play',
          () => openUrl('https://play.google.com'),
        ),
        const SizedBox(height: 8),
        _storeMiniButton(
          Icons.smartphone_rounded,
          'Download on the',
          'iOS App Store',
          () => openUrl('https://apple.com/app-store/'),
        ),
      ],
    );
  }

  Widget _storeMiniButton(
    IconData icon,
    String overline,
    String store,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: glassDecoration(radius: 10, opacity: 0.55),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: primary),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overline.toUpperCase(),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: onSurfaceVariant,
                    ),
                  ),
                  Text(
                    store,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerTextLink(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
