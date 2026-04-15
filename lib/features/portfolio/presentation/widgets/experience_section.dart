import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/portfolio_entities.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      color: colors.bg2,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('exp-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Work History',
              titlePlain: 'Experience &',
              titleAccent: 'Training',
            ),
          ),
          const SizedBox(height: 40),
          _Timeline(experiences: experiences),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<Experience> experiences;

  const _Timeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vertical line column
        Column(
          children: [
            const SizedBox(height: 6),
            Container(
              width: 1,
              // Rough height: each item ~120px
              height: experiences.length * 120.0,
              color: colors.border,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: experiences.asMap().entries.map((entry) {
              return RevealOnScroll(
                key: ValueKey('exp-item-${entry.key}'),
                delay: Duration(milliseconds: entry.key * 90),
                slideX: 0.03,
                child: _TimelineItem(
                  experience: entry.value,
                  isFirst: entry.key == 0,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isFirst;

  const _TimelineItem({
    required this.experience,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot — offset to sit on the timeline line
          Transform.translate(
            offset: Offset(
              -(experience.isPrimary ? 7.5 : 5.0),
              4,
            ),
            child: Container(
              width: experience.isPrimary ? 14 : 10,
              height: experience.isPrimary ? 14 : 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: experience.isPrimary ? colors.accent : colors.bg2,
                border: Border.all(
                  color: experience.isPrimary ? colors.accent : colors.border,
                  width: 2,
                ),
                boxShadow: experience.isPrimary
                    ? [
                        BoxShadow(
                          color: colors.accent.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _RoleText(experience: experience),
                          const SizedBox(height: 2),
                          _DateText(period: experience.period),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _RoleText(experience: experience),
                          ),
                          _DateText(period: experience.period),
                        ],
                      ),
                const SizedBox(height: 4),
                Text(
                  experience.company,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colors.accent,
                  ),
                ),
                if (isFirst) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: colors.tagBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Latest Role',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: colors.tagText,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  experience.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: colors.textSecondary,
                    height: 1.7,
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

class _RoleText extends StatelessWidget {
  final Experience experience;
  const _RoleText({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Text(
      experience.role,
      style: GoogleFonts.syne(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: context.colors.textPrimary,
      ),
    );
  }
}

class _DateText extends StatelessWidget {
  final String period;
  const _DateText({required this.period});

  @override
  Widget build(BuildContext context) {
    return Text(
      period,
      style: GoogleFonts.dmSans(
        fontSize: 12,
        color: context.colors.textHint,
      ),
    );
  }
}
