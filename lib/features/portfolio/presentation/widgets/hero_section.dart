import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/portfolio_entities.dart';

class HeroSection extends StatelessWidget {
  final PortfolioData data;

  const HeroSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 680),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child: Stack(
        children: [
          // Background grid
          Positioned.fill(child: _GridBackground()),

          // Accent glow
          Positioned(
            top: -60,
            right: isMobile ? -80 : 0,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.accent.withOpacity(0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Available badge
              _AvailableBadge()
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 500.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 28),

              // Headline
              _HeroHeadline(data: data)
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 24),

              // Bio
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(
                  data.bio,
                  style: GoogleFonts.dmSans(
                    fontSize: isMobile ? 15 : 17,
                    fontWeight: FontWeight.w300,
                    color: colors.textSecondary,
                    height: 1.75,
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

              const SizedBox(height: 32),

              // CTAs
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _PrimaryButton(label: 'View Projects', onTap: () {}),
                  _OutlineButton(
                    label: 'Get in Touch',
                    onTap: () {},
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

              const SizedBox(height: 52),

              // Stats
              _HeroStats(data: data)
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 600.ms),

              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}

// ── sub-widgets ──────────────────────────────────────────────────────────────

class _GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return CustomPaint(
      painter: _GridPainter(color: colors.border),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  const _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.8;
    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}

class _AvailableBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.tagBg,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingDot(),
          const SizedBox(width: 8),
          Text(
            'Available for opportunities',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors.tagText,
              letterSpacing: 0.04,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 1, end: 0.3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF22C55E),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _HeroHeadline extends StatelessWidget {
  final PortfolioData data;
  const _HeroHeadline({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fontSize = context.isMobile ? 44.0 : 72.0;
    final style = GoogleFonts.syne(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.03,
      height: 1.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter', style: style.copyWith(color: colors.textPrimary)),
        Text(
          'Developer &',
          style: style.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text('Instructor', style: style.copyWith(color: colors.accent)),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: colors.border, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.mail_outline, size: 14, color: colors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroStats extends StatelessWidget {
  final PortfolioData data;
  const _HeroStats({required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      children: [
        _StatItem(num: data.cgpa, suffix: '★', label: 'CGPA'),
        _StatItem(
            num: data.classRank,
            suffix: '',
            label: 'Class Rank (3rd & 4th Year)'),
        _StatItem(num: '5', suffix: '+', label: 'Apps Built'),
        _StatItem(num: '3', suffix: '+', label: 'Years Flutter'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String num;
  final String suffix;
  final String label;

  const _StatItem({
    required this.num,
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
              num,
              style: GoogleFonts.syne(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                letterSpacing: -0.03,
              ),
            ),
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
            letterSpacing: 0.02,
          ),
        ),
      ],
    );
  }
}
