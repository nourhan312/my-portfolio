import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/skill_tag_chip.dart';
import '../../domain/entities/portfolio_entities.dart';

class SkillsSection extends StatelessWidget {
  final List<SkillCategory> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final padding = EdgeInsets.symmetric(
      horizontal: isMobile ? 24 : 80,
      vertical: 72,
    );

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Technical Skills',
            titlePlain: 'What I',
            titleAccent: 'Build With',
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxis =
                  constraints.maxWidth > 900 ? 3 : (isMobile ? 1 : 2);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.6 : 1.4,
                ),
                itemCount: skills.length,
                itemBuilder: (context, i) => _SkillCard(category: skills[i])
                    .animate()
                    .fadeIn(delay: (i * 80).ms, duration: 400.ms)
                    .slideY(begin: 0.15, end: 0),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillCategory category;

  const _SkillCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colors.tagBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(category.icon, style: const TextStyle(fontSize: 20)),
          ),

          const SizedBox(height: 12),

          Text(
            category.label,
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: category.skills
                  .map((s) => SkillTagChip(label: s))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
