import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/skill_tag_chip.dart';
import '../../domain/entities/portfolio_entities.dart';

class SkillsSection extends StatelessWidget {
  final List<SkillCategory> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    // Determine columns: 3 on desktop, 2 on tablet, 1 on mobile
    final cols = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('skills-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Technical Skills',
              titlePlain: 'What I',
              titleAccent: 'Build With',
            ),
          ),
          const SizedBox(height: 40),
          _SkillsGrid(skills: skills, cols: cols),
        ],
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final List<SkillCategory> skills;
  final int cols;

  const _SkillsGrid({required this.skills, required this.cols});

  @override
  Widget build(BuildContext context) {
    // Split skills into rows manually — avoids GridView+shrinkWrap perf issue
    final rows = <List<SkillCategory>>[];
    for (var i = 0; i < skills.length; i += cols) {
      rows.add(
        skills.sublist(i, (i + cols).clamp(0, skills.length)),
      );
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final row = rowEntry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: row.asMap().entries.map((cardEntry) {
              final cardIndex = cardEntry.key;
              final category = cardEntry.value;
              final globalIndex = rowIndex * cols + cardIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: cardIndex == 0 ? 0 : 10,
                    right: cardIndex == row.length - 1 ? 0 : 10,
                  ),
                  child: RevealOnScroll(
                    key: ValueKey('skill-card-$globalIndex'),
                    delay: Duration(milliseconds: globalIndex * 70),
                    slideY: 0.05,
                    child: _SkillCard(category: category),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.accent.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.accent.withValues(alpha: 0.18),
                  colors.accent.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              category.icon,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category.label,
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                category.skills.map((s) => SkillTagChip(label: s)).toList(),
          ),
        ],
      ),
    );
  }
}
