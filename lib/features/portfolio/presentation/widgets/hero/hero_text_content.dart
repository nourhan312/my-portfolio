import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../domain/entities/portfolio_entities.dart';
import 'hero_actions.dart';
import 'hero_badge.dart';
import 'hero_headline.dart';
import 'hero_stats.dart';

class HeroTextContent extends StatelessWidget {
  final PortfolioData data;
  final bool isMobile;
  final Widget? afterHeadline;
  final String keyPrefix;

  const HeroTextContent({
    super.key,
    required this.data,
    required this.isMobile,
    this.afterHeadline,
    required this.keyPrefix,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        RevealOnScroll(
          key: ValueKey('$keyPrefix-badge'),
          delay: const Duration(milliseconds: 80),
          slideY: 0.06,
          child: const HeroAvailabilityBadge(),
        ),
        const SizedBox(height: 28),
        RevealOnScroll(
          key: ValueKey('$keyPrefix-headline'),
          delay: const Duration(milliseconds: 180),
          slideY: 0.06,
          child: HeroTitleBlock(data: data),
        ),
        if (afterHeadline != null) ...[
          const SizedBox(height: 20),
          RevealOnScroll(
            key: ValueKey('$keyPrefix-photo'),
            delay: const Duration(milliseconds: 220),
            slideY: 0.06,
            child: afterHeadline!,
          ),
        ],
        const SizedBox(height: 24),
        RevealOnScroll(
          key: ValueKey('$keyPrefix-bio'),
          delay: const Duration(milliseconds: 280),
          slideY: 0.04,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              data.bio,
              style: GoogleFonts.dmSans(
                fontSize: isMobile ? 18 : 36 * 0.47,
                fontWeight: FontWeight.w400,
                color: colors.textPrimary,
                height: 1.55,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        RevealOnScroll(
          key: ValueKey('$keyPrefix-actions'),
          delay: const Duration(milliseconds: 360),
          slideY: 0.04,
          child: const HeroActions(),
        ),
        const SizedBox(height: 46),
        RevealOnScroll(
          key: ValueKey('$keyPrefix-stats'),
          delay: const Duration(milliseconds: 440),
          slideY: 0.04,
          child: HeroStats(data: data),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
