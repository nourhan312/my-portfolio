import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/portfolio_entities.dart';

class AchievementsSection extends StatelessWidget {
  final List<Achievement> achievements;

  const AchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final cols = isMobile ? 1 : 2;

    final rows = <List<Achievement>>[];
    for (var i = 0; i < achievements.length; i += cols) {
      rows.add(achievements.sublist(i, (i + cols).clamp(0, achievements.length)));
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('ach-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Recognition & Community',
              titlePlain: 'Achievements &',
              titleAccent: 'Volunteering',
            ),
          ),
          const SizedBox(height: 40),
          ...rows.asMap().entries.map((rowEntry) {
            final rowIndex = rowEntry.key;
            final row = rowEntry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: row.asMap().entries.map((cardEntry) {
                  final cardIndex = cardEntry.key;
                  final globalIndex = rowIndex * cols + cardIndex;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: cardIndex == 0 ? 0 : 8,
                        right: cardIndex == row.length - 1 ? 0 : 8,
                      ),
                      child: RevealOnScroll(
                        key: ValueKey('ach-card-$globalIndex'),
                        delay: Duration(milliseconds: globalIndex * 80),
                        slideY: 0.04,
                        child: _AchievementCard(
                          achievement: cardEntry.value,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(achievement.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: GoogleFonts.syne(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: colors.textHint,
                    height: 1.5,
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
