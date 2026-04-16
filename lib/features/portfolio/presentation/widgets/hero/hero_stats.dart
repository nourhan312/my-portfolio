import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/portfolio_entities.dart';

class HeroStats extends StatelessWidget {
  final PortfolioData data;

  const HeroStats({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      children: [
        _StatItem(value: data.cgpa, suffix: '★', label: 'CGPA'),
        _StatItem(
          value: data.classRank,
          suffix: '',
          label: 'Class Rank (3rd & 4th Year)',
        ),
        const _StatItem(value: '5', suffix: '+', label: 'Apps Built'),
        const _StatItem(value: '3', suffix: '+', label: 'Years Flutter'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String suffix;
  final String label;

  const _StatItem({
    required this.value,
    required this.suffix,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: GoogleFonts.syne(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                letterSpacing: -0.03,
              ),
            ),
            if (suffix.isNotEmpty)
              Text(
                suffix,
                style: GoogleFonts.syne(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colors.accent,
                ),
              ),
          ],
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: colors.textHint,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
