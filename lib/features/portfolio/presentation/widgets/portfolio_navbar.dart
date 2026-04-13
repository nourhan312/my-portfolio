import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';

class PortfolioNavBar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  final void Function(String section) onNavTap;

  const PortfolioNavBar({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 64,
      ),
      decoration: BoxDecoration(
        color: colors.bg.withOpacity(0.88),
        border: Border(
          bottom: BorderSide(color: colors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Text(
            'Nourhan',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: colors.textPrimary,
              letterSpacing: -0.02,
            ),
          ),
          Text(
            '.',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: colors.accent,
            ),
          ),

          const Spacer(),

          // Nav links — hidden on mobile
          if (!context.isMobile)
            Row(
              children: AppSections.all.map((section) {
                return _NavLink(
                  label: section,
                  onTap: () => onNavTap(section),
                );
              }).toList(),
            ),

          const SizedBox(width: 16),

          // Theme toggle
          GestureDetector(
            onTap: onThemeToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 44,
              height: 26,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: colors.bg2,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: colors.border),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    isDark ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: colors.accent,
                    shape: BoxShape.circle,
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

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
