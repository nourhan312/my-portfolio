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
          const SizedBox(height: 16),
          RevealOnScroll(
            key: const ValueKey('exp-highlights'),
            delay: const Duration(milliseconds: 80),
            slideY: 0.04,
            child: _ExperienceHighlights(experiences: experiences),
          ),
          const SizedBox(height: 40),
          _Timeline(experiences: experiences),
        ],
      ),
    );
  }
}

class _ExperienceHighlights extends StatelessWidget {
  final List<Experience> experiences;

  const _ExperienceHighlights({required this.experiences});

  @override
  Widget build(BuildContext context) {
    final currentCount = experiences
        .where((e) => e.period.toLowerCase().contains('present'))
        .length;
    final trainingCount = experiences
        .where(
          (e) =>
              e.role.toLowerCase().contains('trainee') ||
              e.role.toLowerCase().contains('training'),
        )
        .length;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _InfoPill(label: 'Current Roles', value: currentCount.toString()),
        _InfoPill(label: 'Total Roles', value: experiences.length.toString()),
        _InfoPill(label: 'Training', value: trainingCount.toString()),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.96, end: 1),
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOut,
      builder: (context, t, child) {
        return Transform.scale(scale: t, child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: colors.accent,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<Experience> experiences;

  const _Timeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    final sortedExperiences = experiences.toList()
      ..sort((a, b) => _compareByPeriod(a.period, b.period));

    return Column(
      children: sortedExperiences.asMap().entries.map((entry) {
        return RevealOnScroll(
          key: ValueKey('exp-item-${entry.key}'),
          delay: Duration(milliseconds: entry.key * 90),
          slideX: 0.03,
          child: _TimelineItem(
            experience: entry.value,
            isFirst: entry.key == 0,
            hasLine: entry.key != sortedExperiences.length - 1,
          ),
        );
      }).toList(),
    );
  }

  static int _compareByPeriod(String a, String b) {
    final aCurrent = _isCurrent(a);
    final bCurrent = _isCurrent(b);
    if (aCurrent != bCurrent) {
      return aCurrent ? -1 : 1;
    }

    final endCompare = _endDate(b).compareTo(_endDate(a));
    if (endCompare != 0) {
      return endCompare;
    }

    return _startDate(b).compareTo(_startDate(a));
  }

  static bool _isCurrent(String period) =>
      period.toLowerCase().contains('present');

  static DateTime _startDate(String period) {
    final parts = period.split('–');
    final start = parts.isNotEmpty ? parts.first.trim() : period.trim();
    return _parseMonthYear(start, endOfMonth: false);
  }

  static DateTime _endDate(String period) {
    if (_isCurrent(period)) {
      return DateTime(9999, 12, 31);
    }

    final parts = period.split('–');
    final end = parts.length > 1 ? parts.last.trim() : parts.first.trim();
    return _parseMonthYear(end, endOfMonth: true);
  }

  static DateTime _parseMonthYear(String value, {required bool endOfMonth}) {
    final cleaned = value.trim();
    if (cleaned.isEmpty) {
      return DateTime(1970, 1, 1);
    }

    final tokens = cleaned.split(RegExp(r'\s+'));
    if (tokens.length < 2) {
      final year = int.tryParse(tokens.first) ?? 1970;
      return DateTime(year, 1, 1);
    }

    final monthMap = <String, int>{
      'jan': 1,
      'january': 1,
      'feb': 2,
      'february': 2,
      'mar': 3,
      'march': 3,
      'apr': 4,
      'april': 4,
      'may': 5,
      'jun': 6,
      'june': 6,
      'jul': 7,
      'july': 7,
      'aug': 8,
      'august': 8,
      'sep': 9,
      'september': 9,
      'oct': 10,
      'october': 10,
      'nov': 11,
      'november': 11,
      'dec': 12,
      'december': 12,
    };

    final month = monthMap[tokens.first.toLowerCase()] ?? 1;
    final year = int.tryParse(tokens.last) ?? 1970;

    if (!endOfMonth) {
      return DateTime(year, month, 1);
    }
    return DateTime(year, month + 1, 0);
  }
}

class _TimelineItem extends StatefulWidget {
  final Experience experience;
  final bool isFirst;
  final bool hasLine;

  const _TimelineItem({
    required this.experience,
    required this.isFirst,
    required this.hasLine,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;
    final experience = widget.experience;
    final isCurrent = experience.period.toLowerCase().contains('present');
    final isTraining = experience.role.toLowerCase().contains('trainee') ||
        experience.role.toLowerCase().contains('training');

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 18),
                Container(
                  width: experience.isPrimary ? (_hovered ? 16 : 14) : 11,
                  height: experience.isPrimary ? (_hovered ? 16 : 14) : 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: experience.isPrimary ? colors.accent : colors.card,
                    border: Border.all(
                      color:
                          experience.isPrimary ? colors.accent : colors.border,
                      width: 2,
                    ),
                    boxShadow: experience.isPrimary
                        ? [
                            BoxShadow(
                              color: colors.accent.withValues(alpha: 0.26),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
                if (widget.hasLine)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 2,
                    height: 132,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: _hovered
                          ? colors.accent.withValues(alpha: 0.35)
                          : colors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                offset: _hovered && !isMobile
                    ? const Offset(0, -0.01)
                    : Offset.zero,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _hovered
                          ? colors.accent.withValues(alpha: 0.5)
                          : colors.border,
                    ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: colors.accent.withValues(alpha: 0.13),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _RoleText(experience: experience),
                                const SizedBox(height: 4),
                                _DateText(period: experience.period),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _RoleText(experience: experience),
                                ),
                                const SizedBox(width: 12),
                                _DateText(period: experience.period),
                              ],
                            ),
                      const SizedBox(height: 6),
                      Text(
                        experience.company,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colors.accent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (widget.isFirst)
                            const _MiniBadge(label: 'Latest Role'),
                          if (isCurrent)
                            const _MiniBadge(
                              label: 'Current',
                              highlighted: true,
                            ),
                          _MiniBadge(
                            label: isTraining ? 'Training' : 'Experience',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  final String label;
  final bool highlighted;

  const _MiniBadge({required this.label, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color:
            highlighted ? colors.accent.withValues(alpha: 0.13) : colors.tagBg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: highlighted
              ? colors.accent.withValues(alpha: 0.28)
              : colors.border,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: highlighted ? colors.accent : colors.tagText,
        ),
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
