import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extensions.dart';

/// Reusable section label + heading used in every portfolio section.
class SectionHeader extends StatelessWidget {
  final String label;
  final String titlePlain;
  final String titleAccent;

  const SectionHeader({
    super.key,
    required this.label,
    required this.titlePlain,
    required this.titleAccent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.12,
            color: colors.accent,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$titlePlain ',
                style: GoogleFonts.syne(
                  fontSize: context.isMobile ? 28 : 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.03,
                  color: colors.textPrimary,
                  height: 1.15,
                ),
              ),
              TextSpan(
                text: titleAccent,
                style: GoogleFonts.syne(
                  fontSize: context.isMobile ? 28 : 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.03,
                  color: colors.accent,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
