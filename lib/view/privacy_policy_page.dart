import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tifltails_official/components/colors.dart';
import 'package:tifltails_official/utils/utils.dart';
import 'package:tifltails_official/view/footer.dart';
import 'package:tifltails_official/view/header.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String? _markdownContent;
  bool _isLoading = true;
  String? _errorMessage;
  final ScrollController _scrollController = ScrollController();

  final List<String> _sections = [
    "1. Introduction",
    "2. Information We Collect",
    "3. Device Permissions",
    "4. How We Use Your Information",
    "5. How Your Information Is Shared",
    "6. Data Storage and Security",
    "7. Data Retention & Account Deletion",
    "8. Children's Privacy",
    "9. Third-Party Links",
    "10. Changes to This Policy",
    "11. Contact Us",
  ];

  @override
  void initState() {
    super.initState();
    _loadPrivacyPolicy();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPrivacyPolicy() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final List<String> candidatePaths = [
      'assets/docs/PRIVACY_POLICY.md',
      'assets/docs/privacy_policy.md',
      'assets/docs/priivacy_policy.md',
    ];

    for (final path in candidatePaths) {
      try {
        final content = await rootBundle.loadString(path);
        if (content.isNotEmpty) {
          if (mounted) {
            setState(() {
              _markdownContent = content;
              _isLoading = false;
            });
          }
          return;
        }
      } catch (_) {
        // Try next candidate path
      }
    }

    if (mounted) {
      setState(() {
        _errorMessage = "Failed to load the Privacy Policy document.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      backgroundColor: background,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 66),
        child: Header(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Top Hero / Header Banner
            _buildHeroHeader(context, isMobile),

            // Content Area
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 24 : 40,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Policy Content
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(isMobile ? 20 : 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEBECEF)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildBodyContent(context, isMobile),
                    ),
                  ),

                  // Desktop Side Navigation Card
                  if (!isMobile) ...[
                    const SizedBox(width: 32),
                    SizedBox(
                      width: 280,
                      child: _buildSideNav(context),
                    ),
                  ],
                ],
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF34495E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: isMobile ? 36 : 56,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Colors.white70, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "Home",
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("/", style: TextStyle(color: Colors.white38, fontSize: 14)),
                  ),
                  Text(
                    "Privacy Policy",
                    style: GoogleFonts.inter(
                      color: primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Title and Icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primary.withValues(alpha: 0.4)),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy Policy",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: isMobile ? 28 : 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "TiflTails official data protection, privacy guidelines & user rights",
                          style: GoogleFonts.inter(
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Badges
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  _buildBadge(
                    icon: Icons.calendar_today_outlined,
                    label: "Last Updated: August 17, 2026",
                  ),
                  _buildBadge(
                    icon: Icons.verified_user_outlined,
                    label: "Google Play & App Store Compliant",
                  ),
                  _buildBadge(
                    icon: Icons.lock_outline,
                    label: "TLS / HTTPS Encrypted",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, bool isMobile) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
              SizedBox(height: 16),
              Text(
                "Loading Privacy Policy...",
                style: TextStyle(color: textPrimary, fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: primary, size: 48),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 16, color: textPrimary),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadPrivacyPolicy,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text("Retry", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MarkdownBody(
      data: _markdownContent ?? '',
      selectable: true,
      onTapLink: (text, href, title) {
        if (href != null && href.isNotEmpty) {
          openUrl(href);
        }
      },
      styleSheet: MarkdownStyleSheet(
        h1: GoogleFonts.playfairDisplay(
          fontSize: isMobile ? 24 : 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1E293B),
          height: 1.3,
        ),
        h1Padding: const EdgeInsets.only(top: 16, bottom: 16),
        h2: GoogleFonts.inter(
          fontSize: isMobile ? 18 : 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1E293B),
          height: 1.3,
        ),
        h2Padding: const EdgeInsets.only(top: 28, bottom: 12),
        h3: GoogleFonts.inter(
          fontSize: isMobile ? 15 : 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
          height: 1.3,
        ),
        h3Padding: const EdgeInsets.only(top: 20, bottom: 8),
        p: GoogleFonts.inter(
          fontSize: isMobile ? 14 : 15,
          color: const Color(0xFF475569),
          height: 1.7,
        ),
        pPadding: const EdgeInsets.only(bottom: 12),
        strong: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1E293B),
        ),
        em: GoogleFonts.inter(
          fontStyle: FontStyle.italic,
          color: const Color(0xFF475569),
        ),
        listBullet: GoogleFonts.inter(
          fontSize: 15,
          color: primary,
          fontWeight: FontWeight.bold,
        ),
        listIndent: 24,
        tableHead: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1E293B),
        ),
        tableBody: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFF475569),
          height: 1.5,
        ),
        tableBorder: TableBorder.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
          borderRadius: BorderRadius.circular(6),
        ),
        tableHeadAlign: TextAlign.left,
        tableCellsPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        tableColumnWidth: const FlexColumnWidth(),
        horizontalRuleDecoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
        ),
        blockquote: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF64748B),
          fontStyle: FontStyle.italic,
          height: 1.6,
        ),
        blockquoteDecoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: const Border(
            left: BorderSide(color: primary, width: 4),
          ),
        ),
        blockquotePadding: const EdgeInsets.all(16),
        code: GoogleFonts.jetBrainsMono(
          fontSize: 13,
          color: primaryDark,
          backgroundColor: const Color(0xFFFFF1F1),
        ),
        a: GoogleFonts.inter(
          color: primary,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildSideNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEBECEF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.list_alt, size: 20, color: primary),
              const SizedBox(width: 8),
              Text(
                "Table of Contents",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          ..._sections.map(
            (section) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 5, color: primary),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      section,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF475569),
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Help / Inquiries box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: primaryLight.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primary.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.mail_outline, size: 16, color: primaryDark),
                    const SizedBox(width: 6),
                    Text(
                      "Need Assistance?",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "For data requests or inquiries, reach us at privacy@tifltails.com",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => openUrl("mailto:privacy@tifltails.com"),
                    child: Text(
                      "Contact Privacy Team →",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
