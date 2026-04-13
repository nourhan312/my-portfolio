import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
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
          const SectionHeader(
            label: 'Work History',
            titlePlain: 'Experience &',
            titleAccent: 'Training',
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 40),

          // Timeline
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vertical line
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: 1,
                        color: colors.border,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 0),

                // Entries
                Expanded(
                  child: Column(
                    children: experiences
                        .asMap()
                        .entries
                        .map(
                          (entry) => _TimelineItem(
                            experience: entry.value,
                            index: entry.key,
                          )
                              .animate()
                              .fadeIn(
                                delay: (entry.key * 100).ms,
                                duration: 500.ms,
                              )
                              .slideX(begin: 0.05, end: 0),
                        )
                        .toList(),
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

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final int index;

  const _TimelineItem({required this.experience, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot
          Transform.translate(
            offset: const Offset(-8, 5),
            child: Container(
              width: experience.isPrimary ? 14 : 10,
              height: experience.isPrimary ? 14 : 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    experience.isPrimary ? colors.accent : colors.bg2,
                border: Border.all(
                  color:
                      experience.isPrimary ? colors.accent : colors.border,
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

          const SizedBox(width: 20),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Role + date row
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
                          Expanded(child: _RoleText(experience: experience)),
                          _DateText(period: experience.period),
                        ],
                      ),

                const SizedBox(height: 4),

                // Company
                Text(
                  experience.company,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.colors.accent,
                  ),
                ),

                const SizedBox(height: 6),

                // Badge for primary
                if (experience.isPrimary && index == 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.tagBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Latest Role',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: context.colors.tagText,
                        ),
                      ),
                    ),
                  ),

                // Description
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
        fontWeight: FontWeight.w400,
        color: context.colors.textHint,
      ),
    );
  }
}
