import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/portfolio_entities.dart';

class ContactSection extends StatelessWidget {
  final PortfolioData data;

  const ContactSection({super.key, required this.data});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Container(
      color: colors.bg2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('contact-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Get In Touch',
              titlePlain: "Let's",
              titleAccent: 'Connect',
            ),
          ),
          const SizedBox(height: 14),
          RevealOnScroll(
            key: const ValueKey('contact-desc'),
            delay: const Duration(milliseconds: 120),
            slideY: 0.04,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'Open to Flutter developer opportunities, product collaborations, and impactful mobile projects.',
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: colors.textSecondary,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              RevealOnScroll(
                key: const ValueKey('contact-email'),
                delay: const Duration(milliseconds: 160),
                slideY: 0.04,
                child: _ContactLink(
                  icon: Icons.email_outlined,
                  label: data.email,
                  onTap: () => _launch('mailto:${data.email}'),
                ),
              ),
              RevealOnScroll(
                key: const ValueKey('contact-linkedin'),
                delay: const Duration(milliseconds: 280),
                slideY: 0.04,
                child: _ContactLink(
                  icon: Icons.link,
                  label: 'LinkedIn',
                  onTap: () => _launch(data.linkedIn),
                ),
              ),
              RevealOnScroll(
                key: const ValueKey('contact-github'),
                delay: const Duration(milliseconds: 340),
                slideY: 0.04,
                child: _ContactLink(
                  icon: Icons.code,
                  label: 'GitHub',
                  onTap: () => _launch(data.github),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered ? colors.accent : colors.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: colors.accent.withValues(alpha: 0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? colors.accent : colors.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: _hovered ? colors.accent : colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
