import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/extensions/context_extensions.dart';

class HeroActions extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onGetInTouch;

  const HeroActions({
    super.key,
    this.onViewProjects,
    this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _ActionButton(
          label: 'View Projects',
          icon: Icons.arrow_forward,
          filled: true,
          onTap: onViewProjects,
        ),
        _ActionButton(
          label: 'Get in Touch',
          icon: Icons.mail_outline,
          filled: false,
          onTap: onGetInTouch,
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textColor = widget.filled
        ? Colors.white
        : (_hovered ? colors.accent : colors.textPrimary);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          offset: _hovered ? const Offset(0, -0.03) : Offset.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: widget.filled
                  ? (_hovered ? const Color(0xFF1A3FA0) : colors.accent)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.filled
                    ? Colors.transparent
                    : (_hovered ? colors.accent : colors.textPrimary),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(widget.icon, size: 22, color: textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

