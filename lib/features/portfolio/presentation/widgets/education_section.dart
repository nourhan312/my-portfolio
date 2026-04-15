import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/portfolio_entities.dart';

class EducationSection extends StatelessWidget {
  final PortfolioData data;

  const EducationSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Container(
      color: colors.bg2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('edu-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Academic Background',
              titlePlain: '',
              titleAccent: 'Education',
            ),
          ),
          const SizedBox(height: 40),
          RevealOnScroll(
            key: const ValueKey('edu-card'),
            delay: const Duration(milliseconds: 150),
            slideY: 0.05,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.border),
              ),
              child: isMobile
                  ? _EduContent(data: data)
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: colors.tagBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '🎓',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(child: _EduContent(data: data)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EduContent extends StatelessWidget {
  final PortfolioData data;
  const _EduContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bachelor of Computer Science',
          style: GoogleFonts.syne(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Benha University — Faculty of Computers and AI',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colors.accent,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          children: [
            Text('2021 – 2025',
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: colors.textHint)),
            Text('Banha, Egypt',
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: colors.textHint)),
            Text('CGPA: ${data.cgpa}',
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: colors.textHint)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.bg2,
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: BorderSide(color: colors.accent, width: 3),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HighlightLine(
                emoji: '🏆',
                text: 'Ranked #1 in 3rd and 4th Year with GPA 3.95',
              ),
              SizedBox(height: 6),
              _HighlightLine(
                emoji: '🎯',
                text:
                    'Graduation Project graded A+ — EEG-Based Smart Assistant',
              ),
              SizedBox(height: 6),
              _HighlightLine(
                emoji: '🤖',
                text:
                    'Classified hand movements via ML & controlled a 4DOF robotic arm',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HighlightLine extends StatelessWidget {
  final String emoji;
  final String text;
  const _HighlightLine({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: colors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
