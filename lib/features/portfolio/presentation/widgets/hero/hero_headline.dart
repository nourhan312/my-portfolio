import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/portfolio_entities.dart';

class HeroTitleBlock extends StatelessWidget {
  final PortfolioData data;

  const HeroTitleBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final nameSize = context.isMobile ? 74.0 : 96.0;
    final roleSize = context.isMobile ? 52.0 : 58.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am',
          style: GoogleFonts.dmSans(
            fontSize: context.isMobile ? 20 : 26,
            fontWeight: FontWeight.w400,
            color: colors.textPrimary,
            height: 1,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          data.name.toUpperCase(),
          style: GoogleFonts.syne(
            fontSize: nameSize,
            fontWeight: FontWeight.w800,
            color: colors.accent,
            letterSpacing: -0.03,
            height: 0.95,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data.title,
          style: GoogleFonts.dmSans(
            fontSize: roleSize * 0.48,
            fontWeight: FontWeight.w500,
            color: colors.textPrimary,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
