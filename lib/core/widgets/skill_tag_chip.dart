import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extensions.dart';

/// Reusable chip for displaying a skill tag.
/// Used in skill cards and project cards.
class SkillTagChip extends StatelessWidget {
  final String label;
  final Color? bgColor;
  final Color? textColor;

  const SkillTagChip({
    super.key,
    required this.label,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor ?? colors.tagBg,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: colors.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor ?? colors.tagText,
        ),
      ),
    );
  }
}
