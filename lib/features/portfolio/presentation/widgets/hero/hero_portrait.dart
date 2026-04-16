import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/portfolio_entities.dart';

class HeroPortrait extends StatefulWidget {
  final PortfolioData data;

  const HeroPortrait({super.key, required this.data});

  @override
  State<HeroPortrait> createState() => _HeroPortraitState();
}

class _HeroPortraitState extends State<HeroPortrait>
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
    final imagePath = widget.data.photoUrl;
    final isAsset = imagePath != null &&
        imagePath.isNotEmpty &&
        imagePath.startsWith('assets/');
    final avatarSize =
        context.isMobile ? 230.0 : (context.isTablet ? 260.0 : 420.0);

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
                  padding: const EdgeInsets.all(8),
                  child: ClipOval(
                    child: imagePath == null || imagePath.isEmpty
                        ? _PortraitFallback(initials: initials)
                        : isAsset
                            ? Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _PortraitFallback(initials: initials),
                              )
                            : Image.network(
                                imagePath,
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
