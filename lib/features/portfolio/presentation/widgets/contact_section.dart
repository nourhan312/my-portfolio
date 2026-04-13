import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
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
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Get In Touch',
            titlePlain: "Let's",
            titleAccent: 'Connect',
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'Open to Flutter developer roles, collaborations, and exciting new projects.',
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: colors.textSecondary,
                height: 1.7,
              ),
            ),
          ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

          const SizedBox(height: 32),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ContactLink(
                icon: Icons.email_outlined,
                label: data.email,
                onTap: () => _launch('mailto:${data.email}'),
              ),
              _ContactLink(
                icon: Icons.phone_outlined,
                label: data.phone,
                onTap: () => _launch('tel:${data.phone}'),
              ),
              _ContactLink(
                icon: Icons.link,
                label: 'LinkedIn',
                onTap: () => _launch(data.linkedIn),
              ),
              _ContactLink(
                icon: Icons.code,
                label: 'GitHub',
                onTap: () => _launch(data.github),
              ),
            ]
                .asMap()
                .entries
                .map(
                  (e) => e.value
                      .animate()
                      .fadeIn(delay: (e.key * 80).ms, duration: 400.ms)
                      .slideY(begin: 0.1, end: 0),
                )
                .toList(),
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? colors.accent : colors.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
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
