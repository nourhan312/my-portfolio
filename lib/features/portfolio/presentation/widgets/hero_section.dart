import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import 'hero/hero_background.dart';
import '../../domain/entities/portfolio_entities.dart';

class HeroSection extends StatelessWidget {
  final PortfolioData data;

  const HeroSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 720),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: IgnorePointer(
                child: HeroAnimatedBackground(
                  dotColor: colors.border,
                  glowColor: colors.accent,
                  dotCount: isMobile ? 58 : 96,
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: isMobile ? -80 : 0,
            child: IgnorePointer(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.accent.withValues(alpha: 0.07),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      RevealOnScroll(
                        key: const ValueKey('hero-badge'),
                        delay: const Duration(milliseconds: 80),
                        slideY: 0.06,
                        child: const _AvailableBadge(),
                      ),
                      const SizedBox(height: 28),
                      RevealOnScroll(
                        key: const ValueKey('hero-headline'),
                        delay: const Duration(milliseconds: 180),
                        slideY: 0.06,
                        child: _HeroHeadline(data: data),
                      ),
                      const SizedBox(height: 22),
                      RevealOnScroll(
                        key: const ValueKey('hero-photo-mobile'),
                        delay: const Duration(milliseconds: 220),
                        slideY: 0.06,
                        child: _HeroPortrait(data: data),
                      ),
                      const SizedBox(height: 24),
                      RevealOnScroll(
                        key: const ValueKey('hero-bio'),
                        delay: const Duration(milliseconds: 280),
                        slideY: 0.04,
                        child: ConstrainedBox(
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
                        ),
                      ),
                      const SizedBox(height: 32),
                      RevealOnScroll(
                        key: const ValueKey('hero-cta'),
                        delay: const Duration(milliseconds: 360),
                        slideY: 0.04,
                        child: const Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _PrimaryButton(label: 'View Projects'),
                            _OutlineButton(label: 'Get in Touch'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 52),
                      RevealOnScroll(
                        key: const ValueKey('hero-stats'),
                        delay: const Duration(milliseconds: 440),
                        slideY: 0.04,
                        child: _HeroStats(data: data),
                      ),
                      const SizedBox(height: 40),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              RevealOnScroll(
                                key: const ValueKey('hero-badge'),
                                delay: const Duration(milliseconds: 80),
                                slideY: 0.06,
                                child: const _AvailableBadge(),
                              ),
                              const SizedBox(height: 28),
                              RevealOnScroll(
                                key: const ValueKey('hero-headline'),
                                delay: const Duration(milliseconds: 180),
                                slideY: 0.06,
                                child: _HeroHeadline(data: data),
                              ),
                              const SizedBox(height: 24),
                              RevealOnScroll(
                                key: const ValueKey('hero-bio'),
                                delay: const Duration(milliseconds: 280),
                                slideY: 0.04,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 560),
                                  child: Text(
                                    data.bio,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: colors.textSecondary,
                                      height: 1.75,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              RevealOnScroll(
                                key: const ValueKey('hero-cta'),
                                delay: const Duration(milliseconds: 360),
                                slideY: 0.04,
                                child: const Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    _PrimaryButton(label: 'View Projects'),
                                    _OutlineButton(label: 'Get in Touch'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 52),
                              RevealOnScroll(
                                key: const ValueKey('hero-stats'),
                                delay: const Duration(milliseconds: 440),
                                slideY: 0.04,
                                child: _HeroStats(data: data),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: isTablet ? 28 : 56),
                      Expanded(
                        flex: 4,
                        child: RevealOnScroll(
                          key: const ValueKey('hero-photo-desktop'),
                          delay: const Duration(milliseconds: 220),
                          slideY: 0.06,
                          child: _HeroPortrait(data: data),
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

class _AvailableBadge extends StatelessWidget {
  const _AvailableBadge();

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
          const _PulsingDot(),
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
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

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
    final fontSize = context.isMobile ? 42.0 : 64.0;
    final roleSize = context.isMobile ? 24.0 : 30.0;
    final parts = data.name
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    final firstName = parts.isNotEmpty ? parts.first.toUpperCase() : data.name;
    final lastName =
        parts.length > 1 ? parts.sublist(1).join(' ').toUpperCase() : '';
    final base = GoogleFonts.syne(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.02,
      height: 1.05,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am',
          style: GoogleFonts.dmSans(
            fontSize: context.isMobile ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: colors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          firstName,
          style: base.copyWith(color: colors.textPrimary),
        ),
        if (lastName.isNotEmpty)
          Text(
            lastName,
            style: base.copyWith(color: colors.textPrimary),
          ),
        const SizedBox(height: 10),
        Text(
          data.title,
          style: GoogleFonts.dmSans(
            fontSize: roleSize,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: colors.accent,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _HeroPortrait extends StatefulWidget {
  final PortfolioData data;
  const _HeroPortrait({required this.data});

  @override
  State<_HeroPortrait> createState() => _HeroPortraitState();
}

class _HeroPortraitState extends State<_HeroPortrait>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatY;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    _floatY = Tween<double>(begin: -4, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _pulse = Tween<double>(begin: 0.98, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final photoUrl = widget.data.photoUrl;
    final isAssetPhoto = photoUrl != null &&
        photoUrl.isNotEmpty &&
        photoUrl.startsWith('assets/');
    final avatarSize =
        context.isMobile ? 220.0 : (context.isTablet ? 250.0 : 300.0);
    final initials = widget.data.name
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Align(
      alignment: context.isMobile ? Alignment.center : Alignment.centerRight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatY.value),
            child: child,
          );
        },
        child: SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _pulse,
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accent.withValues(alpha: 0.12),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors.accent.withValues(alpha: 0.9),
                      colors.accent.withValues(alpha: 0.45),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.accent.withValues(alpha: 0.24),
                      blurRadius: 36,
                      spreadRadius: 2,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: ClipOval(
                    child: photoUrl == null || photoUrl.isEmpty
                        ? _PortraitFallback(initials: initials)
                        : isAssetPhoto
                            ? Image.asset(
                                photoUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _PortraitFallback(initials: initials),
                              )
                            : Image.network(
                                photoUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _PortraitFallback(initials: initials),
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortraitFallback extends StatelessWidget {
  final String initials;
  const _PortraitFallback({required this.initials});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.tagBg, colors.border],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.syne(
            fontSize: 58,
            fontWeight: FontWeight.w700,
            color: colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  const _PrimaryButton({required this.label});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -2.0 : 0.0, 0.0, 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF1A3FA0) : colors.accent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
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
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  const _OutlineButton({required this.label});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -2.0 : 0.0, 0.0, 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered ? colors.accent : colors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _hovered ? colors.accent : colors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.mail_outline,
              size: 14,
              color: _hovered ? colors.accent : colors.textPrimary,
            ),
          ],
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
          label: 'Class Rank (3rd & 4th year)',
        ),
        const _StatItem(num: '6', suffix: '+', label: 'Apps Delivered'),
        const _StatItem(num: '3', suffix: '+', label: 'Years with Flutter'),
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
            if (suffix.isNotEmpty)
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
          ),
        ),
      ],
    );
  }
}
